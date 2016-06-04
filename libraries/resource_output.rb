require 'chef/resource'

class Chef
  class Resource
    # telegraf output resource
    class TelegrafOutput < Chef::Resource
      identity_attr :name

      def initialize(name, run_context = nil)
        super
        @resource_name = :telegraf_output
        @provides = :telegraf_output
        @provider = Chef::Provider::TelegrafOutput
        @action = :create
        @allowed_actions = [:create, :delete, :nothing]
        @name = name
      end

      def config(arg = nil)
        set_or_return(
          :paths, arg,
          :kind_of => Hash,
          :default => {}
        )
      end

      def sensitive(arg = nil)
        set_or_return(
          :sensitive, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => false
        )
      end
    end
  end
end
