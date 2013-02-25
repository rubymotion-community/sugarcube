module SugarCube
  class AnimationChain

    class << self

      def chains
        @chains ||= []
      end

      def start_chain(chain)
        chains << chain unless chains.include?(chain)
      end

      def stop_chain(chain)
        chains.delete(chain)
      end

    end

    def initialize
      raise "animation chains cannot be nested" if Thread.current[:sugarcube_chaining]
      @blocks = []
    end

    def wait(duration)
      and_then(duration: duration) {}
    end

    def and_then(options=nil, &block)
      if options
        options = options.dup
      else
        options = {}
      end
      @blocks << [options, block]
      self
    end

    def << block
      and_then(&block)
    end

    def do_next
      return nil if @block_index >= @blocks.length

      options, block = @blocks[@block_index]
      @after_block = ->(completed){
        if @abort || ! self.do_next
          @running = false
          if @loop
            start
          else
            AnimationChain.stop_chain(self)
          end
        end
      }
      options[:after] = @after_block

      UIView.animate(options) {
        Thread.current[:sugarcube_chaining] = true
        block.call
        Thread.current[:sugarcube_chaining] = nil
        @block_index += 1
      }
      true
    end

    def start
      return if @running
      AnimationChain.start_chain(self)
      @running = true
      @abort = nil
      @block_index = 0
      if Fixnum === @loop
        @loop -= 1
        @loop = nil if @loop == 0
      end
      do_next
      return self
    end

    # @param times [Fixnum,nil] number of times to loop, or any other truthy value to loop forever
    def loop(times=true)
      @loop = times
      start
    end

    # Cancels a loop, but lets the chain finish
    def stop
      @loop = nil
    end

    # stops the animation immediately
    def abort
      return unless @running
      @loop = nil
      @abort = true
      @running = false
    end

  end
end
