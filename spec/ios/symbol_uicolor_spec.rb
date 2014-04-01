describe "Symbol uicolor" do

  describe 'core colors' do
    before do
      @colors = Symbol.uicolors
    end

    it 'should have 21 colors' do
      @colors.size.should == 21
    end

    it 'should have black color' do
      @colors[:black].should == :blackColor
      :black.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have cgcolor method' do
      -> do
        :black.cgcolor.should.not == nil
      end.should.not.raise
    end

    it 'should have blue color' do
      @colors[:blue].should == :blueColor
      :blue.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have brown color' do
      @colors[:brown].should == :brownColor
      :brown.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have cyan color' do
      @colors[:cyan].should == :cyanColor
      :cyan.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have dark_gray color' do
      @colors[:dark_gray].should == :darkGrayColor
      :dark_gray.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have gray color' do
      @colors[:gray].should == :grayColor
      :gray.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have green color' do
      @colors[:green].should == :greenColor
      :green.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have light_gray color' do
      @colors[:light_gray].should == :lightGrayColor
      :light_gray.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have magenta color' do
      @colors[:magenta].should == :magentaColor
      :magenta.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have orange color' do
      @colors[:orange].should == :orangeColor
      :orange.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have purple color' do
      @colors[:purple].should == :purpleColor
      :purple.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have red color' do
      @colors[:red].should == :redColor
      :red.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have yellow color' do
      @colors[:yellow].should == :yellowColor
      :yellow.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have white color' do
      @colors[:white].should == :whiteColor
      :white.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have clear color' do
      @colors[:clear].should == :clearColor
      :clear.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have light_text color' do
      @colors[:light_text].should == :lightTextColor
      :light_text.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have dark_text color' do
      @colors[:dark_text].should == :darkTextColor
      :dark_text.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have table_view color' do
      @colors[:table_view].should == :groupTableViewBackgroundColor
      :table_view.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have scroll_view color' do
      @colors[:scroll_view].should == :scrollViewTexturedBackgroundColor
      :scroll_view.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have flipside color' do
      @colors[:flipside].should == :viewFlipsideBackgroundColor
      :flipside.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have under_page color' do
      @colors[:under_page].should == :underPageBackgroundColor
      :under_page.uicolor.should.be.kind_of(UIColor)
    end
  end

  describe 'css colors' do
    before do
      @colors = Symbol.css_colors
    end

    it 'should have placeholder color' do
      @colors[:placeholder].should.not == nil
      :placeholder.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have aliceblue color' do
      @colors[:aliceblue].should.not == nil
      :aliceblue.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have antiquewhite color' do
      @colors[:antiquewhite].should.not == nil
      :antiquewhite.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have aqua color' do
      @colors[:aqua].should.not == nil
      :aqua.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have aquamarine color' do
      @colors[:aquamarine].should.not == nil
      :aquamarine.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have azure color' do
      @colors[:azure].should.not == nil
      :azure.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have babygray color' do
      @colors[:babygray].should.not == nil
      :babygray.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have beige color' do
      @colors[:beige].should.not == nil
      :beige.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have bisque color' do
      @colors[:bisque].should.not == nil
      :bisque.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have blanchedalmond color' do
      @colors[:blanchedalmond].should.not == nil
      :blanchedalmond.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have blueviolet color' do
      @colors[:blueviolet].should.not == nil
      :blueviolet.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have burlywood color' do
      @colors[:burlywood].should.not == nil
      :burlywood.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have cadetblue color' do
      @colors[:cadetblue].should.not == nil
      :cadetblue.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have chartreuse color' do
      @colors[:chartreuse].should.not == nil
      :chartreuse.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have chocolate color' do
      @colors[:chocolate].should.not == nil
      :chocolate.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have colingray color' do
      @colors[:colingray].should.not == nil
      :colingray.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have coral color' do
      @colors[:coral].should.not == nil
      :coral.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have cornflowerblue color' do
      @colors[:cornflowerblue].should.not == nil
      :cornflowerblue.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have cornsilk color' do
      @colors[:cornsilk].should.not == nil
      :cornsilk.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have crimson color' do
      @colors[:crimson].should.not == nil
      :crimson.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have darkblue color' do
      @colors[:darkblue].should.not == nil
      :darkblue.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have darkcyan color' do
      @colors[:darkcyan].should.not == nil
      :darkcyan.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have darkgoldenrod color' do
      @colors[:darkgoldenrod].should.not == nil
      :darkgoldenrod.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have darkgreen color' do
      @colors[:darkgreen].should.not == nil
      :darkgreen.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have darkkhaki color' do
      @colors[:darkkhaki].should.not == nil
      :darkkhaki.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have darkmagenta color' do
      @colors[:darkmagenta].should.not == nil
      :darkmagenta.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have darkolivegreen color' do
      @colors[:darkolivegreen].should.not == nil
      :darkolivegreen.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have darkorange color' do
      @colors[:darkorange].should.not == nil
      :darkorange.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have darkorchid color' do
      @colors[:darkorchid].should.not == nil
      :darkorchid.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have darkred color' do
      @colors[:darkred].should.not == nil
      :darkred.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have darksalmon color' do
      @colors[:darksalmon].should.not == nil
      :darksalmon.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have darkseagreen color' do
      @colors[:darkseagreen].should.not == nil
      :darkseagreen.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have darkslateblue color' do
      @colors[:darkslateblue].should.not == nil
      :darkslateblue.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have darkslategray color' do
      @colors[:darkslategray].should.not == nil
      :darkslategray.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have darkturquoise color' do
      @colors[:darkturquoise].should.not == nil
      :darkturquoise.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have darkviolet color' do
      @colors[:darkviolet].should.not == nil
      :darkviolet.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have deeppink color' do
      @colors[:deeppink].should.not == nil
      :deeppink.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have deepskyblue color' do
      @colors[:deepskyblue].should.not == nil
      :deepskyblue.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have dimgray color' do
      @colors[:dimgray].should.not == nil
      :dimgray.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have dodgerblue color' do
      @colors[:dodgerblue].should.not == nil
      :dodgerblue.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have firebrick color' do
      @colors[:firebrick].should.not == nil
      :firebrick.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have floralwhite color' do
      @colors[:floralwhite].should.not == nil
      :floralwhite.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have forestgreen color' do
      @colors[:forestgreen].should.not == nil
      :forestgreen.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have fuchsia color' do
      @colors[:fuchsia].should.not == nil
      :fuchsia.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have gainsboro color' do
      @colors[:gainsboro].should.not == nil
      :gainsboro.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have ghostwhite color' do
      @colors[:ghostwhite].should.not == nil
      :ghostwhite.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have gold color' do
      @colors[:gold].should.not == nil
      :gold.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have goldenrod color' do
      @colors[:goldenrod].should.not == nil
      :goldenrod.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have greenyellow color' do
      @colors[:greenyellow].should.not == nil
      :greenyellow.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have honeydew color' do
      @colors[:honeydew].should.not == nil
      :honeydew.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have hotpink color' do
      @colors[:hotpink].should.not == nil
      :hotpink.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have indianred color' do
      @colors[:indianred].should.not == nil
      :indianred.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have indigo color' do
      @colors[:indigo].should.not == nil
      :indigo.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have ivory color' do
      @colors[:ivory].should.not == nil
      :ivory.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have khaki color' do
      @colors[:khaki].should.not == nil
      :khaki.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have lavender color' do
      @colors[:lavender].should.not == nil
      :lavender.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have lavenderblush color' do
      @colors[:lavenderblush].should.not == nil
      :lavenderblush.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have lawngreen color' do
      @colors[:lawngreen].should.not == nil
      :lawngreen.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have lemonchiffon color' do
      @colors[:lemonchiffon].should.not == nil
      :lemonchiffon.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have lightblue color' do
      @colors[:lightblue].should.not == nil
      :lightblue.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have lightcoral color' do
      @colors[:lightcoral].should.not == nil
      :lightcoral.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have lightcyan color' do
      @colors[:lightcyan].should.not == nil
      :lightcyan.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have lightgoldenrodyellow color' do
      @colors[:lightgoldenrodyellow].should.not == nil
      :lightgoldenrodyellow.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have lightgreen color' do
      @colors[:lightgreen].should.not == nil
      :lightgreen.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have lightpink color' do
      @colors[:lightpink].should.not == nil
      :lightpink.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have lightsalmon color' do
      @colors[:lightsalmon].should.not == nil
      :lightsalmon.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have lightseagreen color' do
      @colors[:lightseagreen].should.not == nil
      :lightseagreen.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have lightskyblue color' do
      @colors[:lightskyblue].should.not == nil
      :lightskyblue.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have lightslategray color' do
      @colors[:lightslategray].should.not == nil
      :lightslategray.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have lightsteelblue color' do
      @colors[:lightsteelblue].should.not == nil
      :lightsteelblue.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have lightyellow color' do
      @colors[:lightyellow].should.not == nil
      :lightyellow.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have lime color' do
      @colors[:lime].should.not == nil
      :lime.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have limegreen color' do
      @colors[:limegreen].should.not == nil
      :limegreen.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have linen color' do
      @colors[:linen].should.not == nil
      :linen.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have maroon color' do
      @colors[:maroon].should.not == nil
      :maroon.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have mediumaquamarine color' do
      @colors[:mediumaquamarine].should.not == nil
      :mediumaquamarine.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have mediumblue color' do
      @colors[:mediumblue].should.not == nil
      :mediumblue.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have mediumorchid color' do
      @colors[:mediumorchid].should.not == nil
      :mediumorchid.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have mediumpurple color' do
      @colors[:mediumpurple].should.not == nil
      :mediumpurple.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have mediumseagreen color' do
      @colors[:mediumseagreen].should.not == nil
      :mediumseagreen.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have mediumslateblue color' do
      @colors[:mediumslateblue].should.not == nil
      :mediumslateblue.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have mediumspringgreen color' do
      @colors[:mediumspringgreen].should.not == nil
      :mediumspringgreen.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have mediumturquoise color' do
      @colors[:mediumturquoise].should.not == nil
      :mediumturquoise.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have mediumvioletred color' do
      @colors[:mediumvioletred].should.not == nil
      :mediumvioletred.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have midnightblue color' do
      @colors[:midnightblue].should.not == nil
      :midnightblue.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have mintcream color' do
      @colors[:mintcream].should.not == nil
      :mintcream.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have mistyrose color' do
      @colors[:mistyrose].should.not == nil
      :mistyrose.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have moccasin color' do
      @colors[:moccasin].should.not == nil
      :moccasin.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have navajowhite color' do
      @colors[:navajowhite].should.not == nil
      :navajowhite.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have navy color' do
      @colors[:navy].should.not == nil
      :navy.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have oldlace color' do
      @colors[:oldlace].should.not == nil
      :oldlace.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have olive color' do
      @colors[:olive].should.not == nil
      :olive.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have olivedrab color' do
      @colors[:olivedrab].should.not == nil
      :olivedrab.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have orangered color' do
      @colors[:orangered].should.not == nil
      :orangered.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have orchid color' do
      @colors[:orchid].should.not == nil
      :orchid.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have palegoldenrod color' do
      @colors[:palegoldenrod].should.not == nil
      :palegoldenrod.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have palegreen color' do
      @colors[:palegreen].should.not == nil
      :palegreen.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have paleturquoise color' do
      @colors[:paleturquoise].should.not == nil
      :paleturquoise.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have palevioletred color' do
      @colors[:palevioletred].should.not == nil
      :palevioletred.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have papayawhip color' do
      @colors[:papayawhip].should.not == nil
      :papayawhip.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have peachpuff color' do
      @colors[:peachpuff].should.not == nil
      :peachpuff.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have peru color' do
      @colors[:peru].should.not == nil
      :peru.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have pink color' do
      @colors[:pink].should.not == nil
      :pink.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have plum color' do
      @colors[:plum].should.not == nil
      :plum.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have powderblue color' do
      @colors[:powderblue].should.not == nil
      :powderblue.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have rosybrown color' do
      @colors[:rosybrown].should.not == nil
      :rosybrown.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have royalblue color' do
      @colors[:royalblue].should.not == nil
      :royalblue.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have saddlebrown color' do
      @colors[:saddlebrown].should.not == nil
      :saddlebrown.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have salmon color' do
      @colors[:salmon].should.not == nil
      :salmon.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have sandybrown color' do
      @colors[:sandybrown].should.not == nil
      :sandybrown.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have seagreen color' do
      @colors[:seagreen].should.not == nil
      :seagreen.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have seashell color' do
      @colors[:seashell].should.not == nil
      :seashell.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have sienna color' do
      @colors[:sienna].should.not == nil
      :sienna.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have silver color' do
      @colors[:silver].should.not == nil
      :silver.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have skyblue color' do
      @colors[:skyblue].should.not == nil
      :skyblue.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have slateblue color' do
      @colors[:slateblue].should.not == nil
      :slateblue.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have slategray color' do
      @colors[:slategray].should.not == nil
      :slategray.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have snow color' do
      @colors[:snow].should.not == nil
      :snow.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have springgreen color' do
      @colors[:springgreen].should.not == nil
      :springgreen.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have steelblue color' do
      @colors[:steelblue].should.not == nil
      :steelblue.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have tan color' do
      @colors[:tan].should.not == nil
      :tan.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have teal color' do
      @colors[:teal].should.not == nil
      :teal.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have thistle color' do
      @colors[:thistle].should.not == nil
      :thistle.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have tomato color' do
      @colors[:tomato].should.not == nil
      :tomato.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have torygray color' do
      @colors[:torygray].should.not == nil
      :torygray.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have turquoise color' do
      @colors[:turquoise].should.not == nil
      :turquoise.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have violet color' do
      @colors[:violet].should.not == nil
      :violet.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have wheat color' do
      @colors[:wheat].should.not == nil
      :wheat.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have whitesmoke color' do
      @colors[:whitesmoke].should.not == nil
      :whitesmoke.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have yellowgreen color' do
      @colors[:yellowgreen].should.not == nil
      :yellowgreen.uicolor.should.be.kind_of(UIColor)
    end
  end

  describe 'deprecated colors' do
    before do
      @colors = Symbol.uicolors__deprecated
    end

    it 'should have darkgray color' do
      @colors[:darkgray].should == :dark_gray
      :darkgray.uicolor.should.be.kind_of(UIColor)
    end

    it 'should have lightgray color' do
      @colors[:lightgray].should == :light_gray
      :lightgray.uicolor.should.be.kind_of(UIColor)
    end
  end

end
