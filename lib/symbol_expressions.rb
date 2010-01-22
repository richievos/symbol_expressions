# This extension to Symbol allows Symbol Expressions, such as:
#  >> ["foo", "bar"].map(&:split['']+:join['_'])
#  => ["f_o_o", "b_a_r"]
#  >> [5, "foo", "steve", 1].map(&-:days + :ago)
#  => [Thu Jan 14 11:17:53 -0600 2010, nil, nil, Mon Jan 18 11:17:53 -0600 2010]


module SymbolExpressions

  def -@
    -to_expression
  end
  
  # Returns an ExpressionChain containing this Symbol as an Expression followed by the other expression 
  def +(expression)
    to_expression + expression
  end

  # Returns an Expression object which contains a representation of a method call with this Symbol as a method_id, used with the provided arguments.
  def to_expression(*args)
    Expression.new([self, *args])
  end

  # Short-hand for to_expression
  alias_method :[], :to_expression
  
  # An Expression is a representation of a method call where the first element is the method_id and the rest are the arguments.
  # You can then just say object.send(*@expression) or @expression.to_proc[object]
	class Expression < ::Array

    def -@
      -to_expression_chain
    end
    
    # Returns an expression chain containing this expression and another expression/chain.
    def +(expression)
      to_expression_chain + expression
    end

    # Returns the arguments list for the expression.
    def args
      self[1..-1]||[]
    end

    def inspect #:nodoc:
      ":#{method_id}#{args.inspect}"
    end

    # Returns the method_id for the expression.
    def method_id
      first
    end

    # Returns an ExpressionChain containing this expression.
    def to_expression_chain
      ExpressionChain.new([self])
    end

    # Returns a proc that sends this expression to the proc's argument ala Symbol#to_proc
		def to_proc
		  Proc.new do |object|
		    object.send(*self)
	    end
	  end

    # Returns a Symbol representation of the method_id
	  def to_sym
	    method_id.to_sym
    end

    # Returns a String representation fo the method_id
    def to_s
      first.to_s
    end

	end

  # Represents a chain of method calls, where subsequent expressions are applied to
  # the result of their precedents.
  class ExpressionChain < ::Array

    # Set all expressions in the chain to be optional.
    def -@
      self.optional = true
      self
    end

    # Returns a Symbol, Expression, or ExpressionChain to the current chain.
    def +(expression)
      expression = expression.to_expression if expression.is_a? ::Symbol
      return dup << expression if expression.is_a? Expression
      super
    end

    def inspect #:nodoc:
      map(&:inspect).join('+')
    end

    # Tells whether the chain will short-circuit if the objects passed to apply
    # do not 'respond_to?' the expression method_ids.
    def optional?
      @optional == true
    end
    
    attr_writer :optional

    # Returns a proc where all expressions in this chain are successively applied,
    # starting with the proc's argument.  If the ExpressionChain is 'optional?'
    # that means it tests the object with respond_to? before applying the expression.
    def to_proc
      Proc.new do |object|
        inject(object) do |object, expression|
          break if optional? and !object.respond_to?(expression.method_id)
          object.send(*expression)
        end
      end
    end

    def to_s #:nodoc:
      map(&:to_s).join('.')
    end

  end

end

Symbol.send :include, SymbolExpressions
