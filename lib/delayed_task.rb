module DelayedTask
  class PerformableTask < Struct.new(:task, :targs)
    def perform
      args = targs.count > 0 ? "[targs.join(',')]" : ''
      cmd  = "rake #{task}#{args}"
      puts "Executing: `#{cmd}`"
      system cmd
    end
  end
end
