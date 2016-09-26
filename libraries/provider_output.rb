class Chef
  class Provider
    # provides telegraf_output
    class TelegrafOutput < Chef::Provider
      provides :telegraf_output if respond_to?(:provides)

      def initialize(*args)
        super
      end

      def whyrun_supported?
        true
      end

      def load_current_resource
        true
      end

      def action_create
        new_resource.updated_by_last_action(config_file)
      end

      def action_delete
        new_resource.updated_by_last_action(config_file)
      end

      protected

      def config_file
        require 'toml'

        file_content = TOML.dump('outputs' => { new_resource.name => [new_resource.config] })

        t = Chef::Resource::File.new("output_#{new_resource.name}", run_context)
        t.path ::File.join(node['telegraf']['conf_d_dir'], "output-#{new_resource.name}.conf")
        t.content file_content
        t.notifies :restart, 'service[telegraf]'
        t.run_action new_resource.action
        t.updated?
      end
    end
  end
end
