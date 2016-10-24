class PresentationHubController < ApplicationController
  before_filter :get_our_brands

  def index
    @global_accessory = GlobalAccessory.last

    # Got to be a better way to do this. Scope? But still have to add in brand and categroy.
    @xaxis_ppt = Brand.last_of_a_category("Xaxis", "ppt_template")
    @xaxis_word = Brand.last_of_a_category("Xaxis", "word_template")
    @xaxis_capa = Brand.last_of_a_category("Xaxis", "capability")

    @lr_ppt = Brand.last_of_a_category("Light Reaction", "ppt_template")
    @lr_word = Brand.last_of_a_category("Light Reaction", "word_template")
    @lr_capa = Brand.last_of_a_category("Light Reaction", "capability")

    @plista_ppt = Brand.last_of_a_category("plista", "ppt_template")
    @plista_word = Brand.last_of_a_category("plista", "word_template")
    @plista_capa = Brand.last_of_a_category("plista", "capability")

    @triad_ppt = Brand.last_of_a_category("Triad", "ppt_template")
    @triad_word = Brand.last_of_a_category("Triad", "word_template")
    @triad_capa = Brand.last_of_a_category("Triad", "capability")

  end

end
