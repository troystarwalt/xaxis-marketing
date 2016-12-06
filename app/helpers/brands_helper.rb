# frozen_string_literal: true
module BrandsHelper

  # "A B C Ć D E F G H I J K L M N O P Q R S Š T U V W X Y Z Ž a b c d e f g h i j k l m n o p q r s š t u v w x y z ž 1 2 3 4 5 6 7 8 9 0 ' ? ' " ! " ( % ) [ # ] { @ } / & < = + x = > &#165;"

  def get_chars
    unicode_chars = ["&#174;", "&#169;", "&#8364;", "&#163;", "&#165;", "&#162;"]
    chars = ('A'..'z').to_a + ('!'..'?').to_a + ('µ'..'ö').to_a + unicode_chars
    chars.split.join(" ")
  end

  # def get_font_name(font_family)
  #   if font_family === "Arial"
  #     "Arial"
  #   elsif font_family === "Gotham"
  #     "Gotham"
  #   else
  #     "Times"
  #   end
  # end

  def get_font_name(brand_slug, font_var)
    if brand_slug === "xaxis"
      if font_var === "a"
        "Arial"
      else
        "Gotham"
      end
    elsif brand_slug === "plista"
      if font_var === "a"
        "Womp"
      else
        "Blarmp"
      end
    elsif brand_slug === "light-reaction"
      if font_var === "a"
        "Hare"
      else
        "Pear"
      end
    else
      if font_var === "a"
        "Dogs"
      else
        "Triad"
      end
    end
  end

end
