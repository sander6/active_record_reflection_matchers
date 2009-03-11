require File.dirname(__FILE__) + '/../lib/active_record_reflection_matchers'
require File.dirname(__FILE__) + '/spec_helper'

describe Sander6::ActiveRecordReflectionMatchers do
  describe "#have_one" do
    it "should work" do
      Thong.should have_one(:thung)
    end
    
    it "should work for negative matching" do
      Thong.should_not have_one(:thing)
    end
    
    describe "#through" do
      it "should work" do
        Thong.should have_one(:theong).through(:theung)
      end
      
      it "should work for negative matching when no association exists" do
        Thong.should_not have_one(:ting).through(:theong)
      end
      
      it "should work for negative matching when the :through join model name is wrong" do
        Thong.should_not have_one(:theung).through(:thing)
      end
    end
  end
  
  describe "#have_many" do
    it "should work" do
      Thing.should have_many(:thangs)
    end
    
    it "should work for negative matching" do
      Thing.should_not have_many(:thungs)
    end
    
    describe "#through" do
      it "should work" do
        Thing.should have_many(:tongs).through(:tings)
      end
      
      it "should work for negative matching when no association exists" do
        Thing.should_not have_many(:thungs).through(:tings)
      end
      
      it "should work for negative matching when the :through join model name is wrong" do
        Thing.should_not have_many(:tongs).through(:thungs)
      end
    end
    
    describe "#as" do
      it "should work" do
        Thing.should have_many(:thongs).as(:thongable)
      end
      
      it "should work for negative matching when no association exists" do
        Thung.should_not have_many(:thongs).as(:thongable)
      end
      
      it "should work for negative matching when the polymorphic interface name is wrong" do
        Thing.should_not have_many(:thongs).as(:thongtastic)        
      end
    end
  end
  
  describe "#have_and_belong_to_many" do
    it "should work" do
      Ting.should have_and_belong_to_many(:tongs)
    end
    
    it "should work for negative matching" do
      Ting.should_not have_and_belong_to_many(:thongs)
    end
  end
  
  describe "#belong_to" do
    it "should work" do
      Thang.should belong_to(:thing)
    end
    
    it "should work for negative matching" do
      Thung.should_not belong_to(:thing)
    end
    
    describe "#polymorphically" do
      it "should work" do
        Thong.should belong_to(:thongable).polymorphically
      end
      
      it "should work for negative matching when no association exists" do
        Thung.should_not belong_to(:thing).polymorphically
      end
      
      it "should work for negative matching when the polymorphically interface name is wrong" do
        Thong.should_not belong_to(:thongtastic).polymorphically        
      end
    end
  end
end