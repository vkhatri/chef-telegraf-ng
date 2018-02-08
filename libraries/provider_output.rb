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
        config_file
      end

      def action_delete
        config_file
      end

      protected

      def config_file
        require 'toml'

        file_content = TOML::Generator.new('outputs' => { new_resource.name => [new_resource.config] }).body

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
