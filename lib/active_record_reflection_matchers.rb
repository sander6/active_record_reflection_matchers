module ActiveRecordReflectionMatchers
  
  def have_one(association)
    HasOneAssociationMatcher.new(association)
  end
  
  def have_many(association)
    HasManyAssociationMatcher.new(association)
  end
  
  def belong_to(association)
    BelongsToAssociationMatcher.new(association)
  end
  
  def have_and_belong_to_many(association)
    HasAndBelongsToManyAssociationMatcher.new(association)
  end
  
  class HasOneAssociationMatcher
    def initialize(association)
      @association = association
    end
    
    def through(through_association)
      HasOneThroughAssociationMatcher.new(@association, through_association)
    end
    
    def matches?(klass)
      @klass = klass
      reflection = @klass.reflect_on_association(@association)
      if reflection
        reflection.macro == :has_one
      else
        false
      end
    end
    
    def failure_message
      "Expected #{@klass.name} to have one #{@association}, but it didn't."
    end
    
    def negative_failure_message
      "Expected #{@klass.name} not to have one #{@association}, but it did."
    end    
  end

  class HasOneThroughAssociationMatcher
    def initialize(association, through_association)
      @association = association
      @through_association = through_association
    end
    
    def matches?(klass)
      @klass = klass
      reflection = @klass.reflect_on_association(@association)
      if reflection
        reflection.macro == :has_one && reflection.options.has_key?(:through) && reflection.options[:through] == @through_association
      else
        false
      end
    end
    
    def failure_message
      "Expected #{@klass.name} to have one #{@association.inspect} through #{@through_association.inspect}, but it didn't."
    end
    
    def negative_failure_message
      "Expected #{@klass.name} not to have one #{@association.inspect} through #{@through_association.inspect}, but it did."
    end
  end
  
  class HasAndBelongsToManyAssociationMatcher
    def initialize(association)
      @association = association
    end
    
    def matches?(klass)
      @klass = klass
      reflection = @klass.reflect_on_association(@association)
      if reflection
        reflection.macro == :has_and_belongs_to_many
      else
        false
      end
    end
    
    def failure_message
      "Expected #{@klass.name} to have and belong to many #{@association.inspect}, but it didn't."
    end

    def negative_failure_message
      "Expected #{@klass.name} not to have and belong to many #{@association.inspect}, but it did."
    end
  end

  class HasManyAssociationMatcher
    def initialize(association)
      @association = association
    end
    
    def through(through_association)
      HasManyThroughAssociationMatcher.new(@association, through_association)
    end
    
    def as(name)
      HasManyAsAssociationMatcher.new(@association, name)
    end
    
    def matches?(klass)
      @klass = klass
      reflection = @klass.reflect_on_association(@association)
      if reflection
        reflection.macro == :has_many
      else
        false
      end
    end
    
    def failure_message
      "Expected #{@klass.name} to have many #{@association}, but it didn't."
    end
    
    def negative_failure_message
      "Expected #{@klass.name} not to have many #{@association}, but it did."
    end
  end
  
  class HasManyThroughAssociationMatcher
    def initialize(association, through_association)
      @association = association
      @through_association = through_association
    end
    
    def matches?(klass)
      @klass = klass
      reflection = @klass.reflect_on_association(@association)
      if reflection
        reflection.macro == :has_many && reflection.options.has_key?(:through) && reflection.options[:through] == @through_association
      else
        false
      end
    end
    
    def failure_message
      "Expected #{@klass.name} to have many #{@association.inspect} through #{@through_association.inspect}, but it didn't."
    end
    
    def negative_failure_message
      "Expected #{@klass.name} not to have many #{@association.inspect} through #{@through_association.inspect}, but it did."
    end
  end
  
  class HasManyAsAssociationMatcher
    def initialize(association, name)
      @association = association
      @name = name
    end
    
    def matches?(klass)
      @klass = klass
      reflection = @klass.reflect_on_association(@association)
      if reflection
        reflection.macro == :has_many && reflection.options.has_key?(:as) && reflection.options[:as] == @name
      else
        false
      end
    end
    
    def failure_message
      "Expected #{@klass.name} to have many #{@association.inspect} as #{@name.inspect}, but it didn't."
    end
    
    def negative_failure_message
      "Expected #{@klass.name} not to have many #{@association.inspect} as #{@name.inspect}, but it did."
    end    
  end
  
  class BelongsToAssociationMatcher
    def initialize(association)
      @association = association
    end

    def polymorphically
      BelongsToPolymorphicallyAssociationMatcher.new(@association)
    end
    
    def matches?(klass)
      @klass = klass
      reflection = @klass.reflect_on_association(@association)
      if reflection
        reflection.macro == :belongs_to
      else
        false
      end
    end
    
    def failure_message
      "Expected #{@klass.name} to belong to #{@association}, but it didn't."
    end
    
    def negative_failure_message
      "Expected #{@klass.name} not to belong to #{@association}, but it did."
    end    
  end

  class BelongsToPolymorphicallyAssociationMatcher
    def initialize(association)
      @association = association
    end
    
    def matches?(klass)
      @klass = klass
      reflection = @klass.reflect_on_association(@association)
      if reflection
        reflection.macro == :belongs_to && reflection.options.has_key?(:polymorphic) && reflection.options[:polymorphic]
      else
        false
      end
    end
    
    def failure_message
      "Expected #{@klass.name} to belong to #{@association} polymorphically, but it didn't."
    end
    
    def negative_failure_message
      "Expected #{@klass.name} not to belong to #{@association} polymorphically, but it did."
    end    
  end
end