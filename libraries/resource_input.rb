require 'chef/resource'

class Chef
  class Resource
    # telegraf input resource
    class TelegrafInput < Chef::Resource
      identity_attr :name

      def initialize(name, run_context = nil)
        super
        @resource_name = :telegraf_input
        @provides = :telegraf_input
        @provider = Chef::Provider::TelegrafInput
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
