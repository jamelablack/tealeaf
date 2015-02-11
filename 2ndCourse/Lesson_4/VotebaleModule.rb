1. Two options for Extracting Common code




2. Metaprogamming to include in your module that will allow your Instance/Class methods to
run as class/instance methods
  module Votetable
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.extend ClassMethods
    end
3. For class methods:
module Votetable
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.extend ClassMethods
    base.class_eval do
      my_class_eval
    end

  end

  class InstanceMethods

    def total_votes
      self.up_votes - self.down_votes
    end

    def up_votes
      self.votes.where(vote: true).size
    end

    def down_votes
      self.votes.where(vote: false).size
    end
  end

  class ClassMethods
    def my_class_method
      puts "This is class method"
    end
  end
end

**One thing to understand is that you can organize the code below into a sub-module to
orchestrate how the code is called:
  module Votetable
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.extend ClassMethods
      base.class_eval do *** calling the class method each time the Post class is called
        my_class_eval
      end
    end
So if you went into rails console and called Post => "This is class method" would load,
 in addition to the Post object.

 4. We can also extract our has_many :votes, as: :voteble association, but we can place this
 in a class method, which will allow it to be fired automatically when the Post class is called
 just as though its in the model:
   class ClassMethods
     has_many :votes, as: :voteable
   end

   #Using Concerns
   module Voteable
     extend ActiveSupport::Concern

     included do
       has_many :votes, as: :voteable
     end



     def total_votes
       self.up_votes - self.down_votes
     end

     def up_votes
       self.votes.where(vote: true).size
     end

     def down_votes
       self.votes.where(vote: false).size
     end

   end
   _________Compairing Metaprogramming vs Using Concerns

   #Using Metaprogramming

   module Voteable
     def self.included(base)
       base.send(:include, InstanceMethods)
       base.extend ClassMethods
     end
  ******************************

     class InstanceMethods

       def total_votes
         self.up_votes - self.down_votes
       end

       def up_votes
         self.votes.where(vote: true).size
       end

       def down_votes
         self.votes.where(vote: false).size
       end
     end

     class ClassMethods
       has_many :votes, as: :voteable
     end
   end
