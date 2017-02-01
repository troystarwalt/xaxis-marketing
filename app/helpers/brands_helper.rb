# frozen_string_literal: true
module BrandsHelper

  # "A B C Ć D E F G H I J K L M N O P Q R S Š T U V W X Y Z Ž a b c d e f g h i j k l m n o p q r s š t u v w x y z ž 1 2 3 4 5 6 7 8 9 0 ' ? ' " ! " ( % ) [ # ] { @ } / & < = + x = > &#165;"

  def get_chars
    unicode_chars = ["&#174;", "&#169;", "&#8364;", "&#163;", "&#165;", "&#162;"]
    chars = ('A'..'z').to_a + ('!'..'?').to_a + ('µ'..'ö').to_a + unicode_chars
    chars.split.join(" ")
  end

  def get_font_name(brand_slug, font_var)
    if brand_slug === "xaxis"
      if font_var === "a"
        "Arial"
      else
        "Gotham"
      end
    elsif brand_slug === "plista"
      if font_var === "a"
        "Calibri"
      elsif font_var === "b"
        "Lato"
      else
        "Myriad"
      end
    elsif brand_slug === "light-reaction"
      if font_var === "a"
        "Arial"
      else
        "Univers"
      end
    else
      if font_var === "a"
        "Tahoma"
      else
        "Lato"
      end
    end
  end

  def content_for_brands
    {xaxis: {
      welcome: "<p>Welcome to the home of all Xaxis brand assets! We have a few guidelines for using the brand resources to ensure our brand is accurately represented.</p>
      <p>We hope this identity system inspires you to create brilliant materials for the Xaxis brand.</p>",
      boilerplate: "<p>Xaxis is the world’s largest programmatic audience company that connects advertisers to audiences across all addressable channels. Through the expert use of proprietary data and advertising technology along with unparalleled media relationships, Xaxis delivers results for over 3,000 clients in 46 markets across North America, Europe, Asia Pacific, Latin America and the Middle East. Advertisers working with Xaxis achieve exceptionally high return on advertising spend through the company’s proprietary media products, as well as through its specialist companies, Light Reaction and plista. For more information,
visit <a href='https://www.xaxis.com'>www.xaxis.com</a>.</p>",
      logo: "<p>The vertical Xaxis logo lock-up is the preferred arrangement, and is available in six variations. In most cases, and whenever possible, use the 4-color version. The negative version of the logo should only be used on a color background.</p>
      <p>The horizontal Xaxis logo is to be used for smaller applications and endorsements. It is available in six variations. In most cases, and whenever possible, use the 4-color version. The negative version of the logo should only be used on a color background.</p>
      <p>For detailed logo usage, please refer to the Xaxis Brand Guidelines.</p>",
      font: "<p>Gotham is the official typeface of Xaxis. It is used in four weights–Extra Light, Book, Medium and Bold. For online and web-based communications, please use Arial for all live copy.</p>",
      images: "<p>Choosing the right image to communicate the brand values and message is very important. The images should also be futuristic and tech-driven. Avoid using business cliché pictures.</p>
      <p>The images should have at least three of these qualities:</p>
      <ul>
      <li>interesting angles</li>
      <li>contrast</li>
      <li>style</li>
      <li>movement</li>
      <li>depth</li>
      <li>audience faces</li>
      </ul>
      <p>Images used in Powerpoint as a background should have an overlay layer of the color #1D3647 at 30% opacity. If you are unsure of how to adjust the layer opacity, just copy and paste the overlay you see on the cover slide in the template!</p>",
      ppt: "<p>The new Xaxis Powerpoint Template is updated with countless selections of icons, layouts and stock images that allow you to build beautiful slides with just a few clicks!</p>
      <p>Remember, <a href='#{presentation_hub_path}'>always check back to the hub</a> for the latest templates and updates!</p>",
      word: "<p>Please make sure all external facing material is written in this template.</p>",
      facts: "<p>Xaxis Fast Facts is a document that contains boilerplates for all Xaxis portfolio brands and statistics such as, number of employees, number of offices, and revenue. This document is updated on a quarterly basis by the Global Marketing team.</p>",
      capa: "<p>The Xaxis Global Capabilities deck includes Xaxis’ core capabilities, corporate structure, and an overview of our products and services. It provides clients with a deep understanding of what Xaxis has to offer as well as our overall mission and objectives.</p>"
    },
    triad: {
      welcome: "<p>Welcome to Triad Retail Media brand resources center!</p>

      <p>This guideline provides the appropriate usage and construction of various Triad Retail Media (TRM) identity elements. Use these elements to accurately communicate our brand. We worked hard to develop this brand for you to be proud of.
      </p>",
      boilerplate: "<p>Triad Retail Media helps the world’s leading retailers and brands create, manage and operate digital media programs, turning their highly trafficked websites into valuable publishing properties. Walmart, eBay, Asda, Toys'R'Us, CVS, Sam’s Club, Staples and Kohl’s are among the major global retailers that rely on Triad Retail Media to connect more than 1,500 brands with shoppers in the purchase mindset. Headquartered in St. Petersburg, Florida, with nearly 700 team members in 14 offices worldwide, Triad Retail Media is the global leader in digital retail media. Founded in 2004, it is part of the Xaxis family of companies, under WPP’s media-buying arm GroupM. For more information, visit <a href='http://www.tiadretail.com'>www.TriadRetail.com</a> or its social media channels: <a href='https://www.linkedin.com/company/triad-retail-media?trk=nav_account_sub_nav_company_admin'>LinkedIn</a>, <a href='https://www.facebook.com/triadretail'>Facebook</a>, <a href='https://twitter.com/triadretail/'>Twitter</a> or <a href='https://www.instagram.com/triadretail/'>Instagram</a>.</p>",
      logo: "<p>The logo is a unique piece of artwork and must never be modified or altered in any way without prior approval. The preferred version of the logo is the vertical orientation; however, if a horizontal version is necessary, the secondary, non-stacked version may be used.</p>

      <p>The Triad Retail Media brand mark (with or without tagline) is to be used in all internal and external deliverables. This includes correspondence, proposals, contracts, editorial strategies, creative decks, and any other documentation that represents the brand and voice of Triad. </p>

      <p>For detailed logo usage, please refer to the Triad Brand Guidelines.
      </p>",
      font: "<p>The official typefaces chosen to represent the Triad Retail Media brand are Magna EF Light and Trade Gothic LT Std. With its sharp edges and clarity of characters, Magna EF Light presents the Triad name as a trusted leader.</p>

      <p>The official typefaces chosen to represent the Triad Retail Media brand in print is Lato. Lato should be the standard font choice when creating print materials. However, if a larger font family is needed, Helvetica Neue LT STD maybe be used.</p>

      <p>To accommodate all different print materials, a large font family that is legible, clean and modern (like Helvetica Neue LT Std) may be used to create a professional and cohesive look on Triad Retail Media’s print material.
      </p>",
      images: "<p>Choosing the right image to communicate the brand values and message is very important.</p>
      <p>The images should have at least three of these qualities:</p>
      <ul>
      <li>interesting angles</li>
      <li>contrast</li>
      <li>style</li>
      <li>movement</li>
      <li>depth</li>
      <li>audience faces</li>
      </ul>
      <p>Images used in Powerpoint as a background should have an overlay layer of the color #1D3647 at 30% opacity. If you are unsure of how to adjust the layer opacity, just copy and paste the overlay you see on the cover slide in the template!</p>",
      ppt: "<p></p>",
      word: "<p></p>",
      facts: "<p></p>",
      capa: "<p>The Triad Global Capabilities Deck are available for download in both Triad template and Xaxis template.</p>"
    },
    plista: {
      welcome: "<p>Welcome to plista brand resources center! plista is our native advertising and content distribution platform.</p>

      <p><strong>plista should always written in lower case letter, without exception.</strong>
        </p>",
        boilerplate: "<p>plista is a pioneer when it comes to innovative solutions for native advertising and content distribution in premium environments. With its data-driven platform, the Berlin based company has been successfully bringing advertisers and media together since 2008. With its proprietary real-time Recommendation Technology, plista is able to deliver both content and advertising that matches users’ individual interests – across all channels and devices. Publishers benefit from longer user visit duration, increased traffic and the additional monetization of their digital products. By using plista’s native ad formats, advertisers are able to address users seamlessly and efficiently along the entire sales funnel. plista employs over 180 people and offers its solutions in 16 international markets. For more information, visit <a href='https://www.plista.com'>www.plista.com</a>.</p>",
        logo: "<p>The primary plista logo should be used on a white background. The reversed white logo can be used on colored background.</p>",
        font: "<p>plista uses the Calibri font for use in the office and in presentations. The font is a component of Microsoft Office for Windows and Apple Macintosh and does not need to be downloaded.</p>

        <p>The font Myriad Pro is the standard font for plista GmbH print media.</p>

        <p>For web design the Google Web Font Lato was chosen.</p>",
        images: "<p>The plista images should have a lot of green and natural feel to it. They should be native, authentic and welcoming. The overall tone should be green for nature, and blue for the ocean.</p>
        <p>The images should have at least three of these qualities:</p>
        <ul>
        <li>interesting angles</li>
        <li>contrast</li>
        <li>style</li>
        <li>movement</li>
        <li>depth</li>
        <li>audience faces</li>
        </ul>
        <p>Images used in Powerpoint as a background should have an overlay layer of the color #1D3647 at 30% opacity. If you are unsure of how to adjust the layer opacity, just copy and paste the overlay you see on the cover slide in the template!</p>",
        ppt: "<p>The plista Powerpoint template has countless selections of icons, layouts and stock images that allow you to build beautiful slides with just a few clicks!</p>
        <p>Remember, <a href='#{presentation_hub_path}'>always check back to the hub</a> for the latest templates and updates!</p>",
        word: "<p>Please make sure all external facing material is written in this template.</p>",
        facts: "<p>plista Fast Facts is a document that contains boilerplates for all Xaxis portfolio brands and statistics such as, number of employees, number of offices, and revenue. This document is updated on a quarterly basis by the Global Marketing team.</p>",
        capa: "<p>For plista, there is a Global Capabilities Deck for Advertiser and a Global Capabilities Deck for Publisher. Please make sure you select the suitable one for your use. </p>"
      },
      lightreaction: {
        welcome: "<p>Welcome to the Light Reaction brand resource center! Here you can find our brand guidelines, brand assets, brand templates, and PR Kit.</p>
        <p>The Light Reaction Brand Guidelines explain how to use our brand assets accurately to represent our brand. Please refer to these when using our brand assets in your internal and external materials.</p>",
        boilerplate: "<p>Light Reaction guarantees real outcomes for brands by combining proprietary media, data and technology at scale. The company’s approach to performance marketing reaches consumers across devices to drive real outcomes for brands. Light Reaction is available in 31 markets across North America, Europe, Asia and the Middle East.  For more information, visit Light Reaction at <a href='http://www.lightreaction.com'>www.lightreaction.com</a>.</p>",
        logo: "<p>Both the primary and horizontal logos are available in three different color treatments, which need to be chosen according to how and where you plan to use the logo.</p>",
        font: "<p>Typography plays a significant role in Light Reaction’s visual system. Universe LT STD is the primary font family of Light Reaction. It should be used in three different weights: Light, Roman and Bold.</p>
        <p>For cases where Universe is not available, Arial can be used in Regular and Bold weights.</p>",
        images: "<p>Choosing the right image to communicate the brand values and message is very important. The Light Reaction images should have heavy use of yellow beam lights, and the overall tone should be warm.</p>
        <p>The images should have at least three of these qualities:</p>
        <ul>
        <li>interesting angles</li>
        <li>contrast</li>
        <li>style</li>
        <li>movement</li>
        <li>depth</li>
        <li>audience faces</li>
        </ul>
        <p>Images used in Powerpoint as a background should have an overlay layer of the color #1D3647 at 30% opacity. If you are unsure of how to adjust the layer opacity, just copy and paste the overlay you see on the cover slide in the template!</p>",
        ppt: "<p>The new Light Reaction Template is updated with countless selections of icons, layouts and stock images that allow you to build beautiful slides with just a few clicks!</p>
        <p>Remember, <a href='#{presentation_hub_path}'>always check back to the hub</a> for the latest templates and updates!</p>",
        word: "<p>Please make sure all external facing material is written in this template.</p>",
        facts: "<p>Light Reaction Fast Facts is a document that contains boilerplates for all Xaxis portfolio brands and statistics such as, number of employees, number of offices, and revenue. This document is updated on a quarterly basis by the Global Marketing team.</p>",
        capa: "<p>The Light Reaction Global Capabilities Deck includes Light Reaction’s mission statement, core capabilities and product offerings.</p>"
      }
    }
  end

  def can_connect?
    open('https://www.box.com/') rescue false
  end
end
