
module Motion module Project
  class App
    class << self
      def pre_setup(&block)
        config_without_setup.pre_setup_blocks << block
      end
      def post_setup(&block)
        config_without_setup.post_setup_blocks << block
      end
    end
  end
end end

module Motion; module Project
  class Config

    def pre_setup_blocks
      @pre_setup_blocks ||= []
    end

    def post_setup_blocks
      @post_setup_blocks ||= []
    end

    alias sugarcube_old_setup setup
    def setup
      app_files = @files.flatten.select { |file| file.start_with?('app/')}
      @files = @files - app_files
      if @pre_setup_blocks
        @pre_setup_blocks.each { |b| b.call(self) }
        @pre_setup_blocks = nil
      end
      @files.concat(app_files)

      sugarcube_old_setup.tap do
        if @post_setup_blocks
          @post_setup_blocks.each { |b| b.call(self) }
          @post_setup_blocks = nil
        end
      end
    end
  end
end end
