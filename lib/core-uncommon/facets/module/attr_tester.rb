class Module

  # Create an tester attribute. This creates a single method
  # used to test the attribute for truth.
  #
  #   attr_tester :a
  #
  # is equivalent to
  #
  #   def a?
  #     @a ? true : @a
  #   end
  #
  # NOTE: This is not (presently) a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.
  #
  # CREDIT: Trans

  def attr_tester(*args)
    code, made = '', []
    args.each do |a|
      code << %{
        def #{a}?(truth=nil)
          @#{a} ? truth || @#{a} : @#{a}
        end
      }
      made << "#{a}?".to_sym
    end
    module_eval code
    made
  end

  # Create aliases for flag reader.
  #
  # NOTE: This is not (presently) a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.
  #
  # CREDIT: Trans

  def alias_tester(*args)
    orig = args.last
    args = args - [orig]
    args.each do |name|
      alias_method("#{name}?", "#{orig}?")
    end
  end

end

