module SugarCube
  class AnimationChain
    class << self

      def chains
        @chains ||= []
      end

      def start_chain(chain)
        chains << chain
      end

      def stop_chain(chain)
        chains ||= []
        @chains.delete(chain)
      end

    end

    def initialize
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
        self.do_next || AnimationChain.stop_chain(self)
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
      AnimationChain.start_chain(self)
      @block_index = 0
      do_next
    end

  end
end
