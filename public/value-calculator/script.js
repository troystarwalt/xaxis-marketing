//support polyfill for old IE
(function() {
  if (!Event.prototype.preventDefault) {
    Event.prototype.preventDefault=function() {
      this.returnValue=false;
    };
  }
  if (!Event.prototype.stopPropagation) {
    Event.prototype.stopPropagation=function() {
      this.cancelBubble=true;
    };
  }
  if (!Element.prototype.addEventListener) {
    var eventListeners=[];
    var addEventListener=function(type,listener /*, useCapture (will be ignored) */) {
      var self=this;
      var wrapper=function(e) {
        e.target=e.srcElement;
        e.currentTarget=self;
        if (typeof listener.handleEvent != 'undefined') {
          listener.handleEvent(e);
        } else {
          listener.call(self,e);
        }
      };
      if (type=="DOMContentLoaded") {
        var wrapper2=function(e) {
          if (document.readyState=="complete") {
            wrapper(e);
          }
        };
        document.attachEvent("onreadystatechange",wrapper2);
        eventListeners.push({object:this,type:type,listener:listener,wrapper:wrapper2});

        if (document.readyState=="complete") {
          var e=new Event();
          e.srcElement=window;
          wrapper2(e);
        }
      } else {
        this.attachEvent("on"+type,wrapper);
        eventListeners.push({object:this,type:type,listener:listener,wrapper:wrapper});
      }
    };
    var removeEventListener=function(type,listener /*, useCapture (will be ignored) */) {
      var counter=0;
      while (counter<eventListeners.length) {
        var eventListener=eventListeners[counter];
        if (eventListener.object==this && eventListener.type==type && eventListener.listener==listener) {
          if (type=="DOMContentLoaded") {
            this.detachEvent("onreadystatechange",eventListener.wrapper);
          } else {
            this.detachEvent("on"+type,eventListener.wrapper);
          }
          eventListeners.splice(counter, 1);
          break;
        }
        ++counter;
      }
    };
    Element.prototype.addEventListener=addEventListener;
    Element.prototype.removeEventListener=removeEventListener;
    if (HTMLDocument) {
      HTMLDocument.prototype.addEventListener=addEventListener;
      HTMLDocument.prototype.removeEventListener=removeEventListener;
    }
    if (Window) {
      Window.prototype.addEventListener=addEventListener;
      Window.prototype.removeEventListener=removeEventListener;
    }
  }
})();
(function() {
    'use strict';

    // Got this from MDN:
    // https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/toLocaleString#Example:_Checking_for_support_for_locales_and_options_arguments
    function toLocaleStringSupportsLocales() {
        var number = 0;
        try {
            number.toLocaleString("i");
        } catch (e) {
            return e.name === "RangeError";
        }
        return false;
    }

    if (!toLocaleStringSupportsLocales()) {
        var replaceSeparators = function(sNum, separators) {
            var sNumParts = sNum.split('.');
            if (separators && separators.thousands) {
                sNumParts[0] = sNumParts[0].replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1" + separators.thousands);
            }
            sNum = sNumParts.join(separators.decimal);

            return sNum;
        };

        var renderFormat = function(template, props) {
            for (var prop in props) {
                template = template.replace("{{" + prop + "}}", props[prop]);
            }

            return template;
        };

        var mapMatch = function(map, locale) {
            var match = locale;
            var language = locale && locale.toLowerCase().match(/^\w+/);

            if (!map.hasOwnProperty(locale)) {
                if (map.hasOwnProperty(language)) {
                    match = language;
                } else {
                    match = "en";
                }
            }

            return map[match];
        };

        var dotThousCommaDec = function(sNum) {
            var separators = {
                decimal: ',',
                thousands: '.'
            };

            return replaceSeparators(sNum, separators);
        };

        var commaThousDotDec = function(sNum) {
            var separators = {
                decimal: '.',
                thousands: ','
            };

            return replaceSeparators(sNum, separators);
        };

        var spaceThousCommaDec = function(sNum) {
            var seperators = {
                decimal: ',',
                thousands: '\u00A0'
            };

            return replaceSeparators(sNum, seperators);
        };

        var apostrophThousDotDec = function(sNum) {
            var seperators = {
                decimal: '.',
                thousands: '\u0027'
            };

            return replaceSeparators(sNum, seperators);
        };

        var transformForLocale = {
            en: commaThousDotDec,
            it: dotThousCommaDec,
            fr: spaceThousCommaDec,
            de: dotThousCommaDec,
            "de-DE": dotThousCommaDec,
            "de-AT": dotThousCommaDec,
            "de-CH": apostrophThousDotDec,
            "de-LI": apostrophThousDotDec,
            "de-BE": dotThousCommaDec,
            ro: dotThousCommaDec,
            "ro-RO": dotThousCommaDec,
            hu: spaceThousCommaDec,
            "hu-HU": spaceThousCommaDec,
            "da-DK": dotThousCommaDec,
            "nb-NO": spaceThousCommaDec
        };

        var currencyFormatMap = {
            en: "pre",
            it: "post",
            fr: "post",
            de: "post",
            "de-DE": "post",
            "de-AT": "prespace",
            "de-CH": "prespace",
            "de-LI": "post",
            "de-BE": "post",
            ro: "post",
            "ro-RO": "post",
            hu: "post",
            "hu-HU": "post",
            "da-DK": "post",
            "nb-NO": "post"
        };

        var currencySymbols = {
            "afn": "؋",
            "ars": "$",
            "awg": "ƒ",
            "aud": "$",
            "azn": "₼",
            "bsd": "$",
            "bbd": "$",
            "byr": "p.",
            "bzd": "BZ$",
            "bmd": "$",
            "bob": "Bs.",
            "bam": "KM",
            "bwp": "P",
            "bgn": "лв",
            "brl": "R$",
            "bnd": "$",
            "khr": "៛",
            "cad": "$",
            "kyd": "$",
            "clp": "$",
            "cny": "¥",
            "cop": "$",
            "crc": "₡",
            "hrk": "kn",
            "cup": "₱",
            "czk": "Kč",
            "dkk": "kr",
            "dop": "RD$",
            "xcd": "$",
            "egp": "£",
            "svc": "$",
            "eek": "kr",
            "eur": "€",
            "fkp": "£",
            "fjd": "$",
            "ghc": "¢",
            "gip": "£",
            "gtq": "Q",
            "ggp": "£",
            "gyd": "$",
            "hnl": "L",
            "hkd": "$",
            "huf": "Ft",
            "isk": "kr",
            "inr": "₹",
            "idr": "Rp",
            "irr": "﷼",
            "imp": "£",
            "ils": "₪",
            "jmd": "J$",
            "jpy": "¥",
            "jep": "£",
            "kes": "KSh",
            "kzt": "лв",
            "kpw": "₩",
            "krw": "₩",
            "kgs": "лв",
            "lak": "₭",
            "lvl": "Ls",
            "lbp": "£",
            "lrd": "$",
            "ltl": "Lt",
            "mkd": "ден",
            "myr": "RM",
            "mur": "₨",
            "mxn": "$",
            "mnt": "₮",
            "mzn": "MT",
            "nad": "$",
            "npr": "₨",
            "ang": "ƒ",
            "nzd": "$",
            "nio": "C$",
            "ngn": "₦",
            "nok": "kr",
            "omr": "﷼",
            "pkr": "₨",
            "pab": "B/.",
            "pyg": "Gs",
            "pen": "S/.",
            "php": "₱",
            "pln": "zł",
            "qar": "﷼",
            "ron": "lei",
            "rub": "₽",
            "shp": "£",
            "sar": "﷼",
            "rsd": "Дин.",
            "scr": "₨",
            "sgd": "$",
            "sbd": "$",
            "sos": "S",
            "zar": "R",
            "lkr": "₨",
            "sek": "kr",
            "chf": "CHF",
            "srd": "$",
            "syp": "£",
            "tzs": "TSh",
            "twd": "NT$",
            "thb": "฿",
            "ttd": "TT$",
            "try": "",
            "trl": "₤",
            "tvd": "$",
            "ugx": "USh",
            "uah": "₴",
            "gbp": "£",
            "usd": "$",
            "uyu": "$U",
            "uzs": "лв",
            "vef": "Bs",
            "vnd": "₫",
            "yer": "﷼",
            "zwd": "Z$"
        };

        var currencyFormats = {
            pre: "{{code}}{{num}}",
            post: "{{num}} {{code}}",
            prespace: "{{code}} {{num}}"
        };

        Number.prototype.toLocaleString = function(locale, options) {
            if (locale && locale.length < 2)
                throw new RangeError("Invalid language tag: " + locale);

            var sNum;

            if (options && options.minimumFractionDigits) {
                sNum = this.toFixed(options.minimumFractionDigits);
            } else {
                sNum = this.toString();
            }

            sNum = mapMatch(transformForLocale, locale)(sNum, options);

            if(options && options.currency && options.style === "currency") {
                var format = currencyFormats[mapMatch(currencyFormatMap, locale)];
                if(options.currencyDisplay === "code") {
                    sNum = renderFormat(format, {
                        num: sNum,
                        code: options.currency.toUpperCase()
                    });
                } else {
                    sNum = renderFormat(format, {
                        num: sNum,
                        code: currencySymbols[options.currency.toLowerCase()]
                    });
                }
            }

            return sNum;
        };
    }

}());

/*
 *
 *
 *
 *
 *Global Constants
 *
 *
 *
 *                                                            */
var constants = {

  displayCPMDiscountPct: 0.87,
  videoCPMDiscountPct: 0.92,
  dataCostPBUPct: 0.0656400892363058,
  verificationAdvertisingPBUPct: 0.0262560356945223,
  viewabilityBenchmarkVideo: 30,
  viewabilityBenchmarkDisplay: 50,
  dspInternalSpendPct: 0.15,
  addons: {
    DMPAddon: {
      dsp: 1,
      pbu: 1,
      xaxis: 0
    },
  },
  initializers: {
    input_total_init: 10000000,
    input_pctOfMediaPbu_init: 12,
    input_mediaCpmVideoDSP_init: 34,
    input_mediaCpmDisplayDSP_init: 8.5,
    select_staffing_init: 'pctOfMedia',
    pbuTechCostPct: 9
  }
};

/*
 *
 *
 *
 *
 * On load set listeners and initialize
 *
 *
 *
 *                                                            */
onload = function(){
  var inputs = document.getElementsByTagName('input');
  var input_videoBudgetWeighting = 'input_videoBudgetWeighting';
  var input_displayBudgetWeighting = 'input_displayBudgetWeighting';
  for(var i=0; i<inputs.length; i++) {
    if (inputs[i].addEventListener) {
      inputs[i].addEventListener('change', setWeightings , {passive: true });
      inputs[i].addEventListener('keyup', setWeightings, {passive: true });
      inputs[i].addEventListener('click', setWeightings, {passive: true });
    } else if (inputs[i].attachEvent)  {
      inputs[i].attachEvent('change', setWeightings);
      inputs[i].attachEvent('keyup', setWeightings);
      inputs[i].attachEvent('click', setWeightings);
    }
  }
  var staffing_select = document.getElementById('select_staffing');
  if (staffing_select.addEventListener) {
    staffing_select.addEventListener('change', setFTEorPctOfMedia , {passive: true });
  }
  else if (staffing_select.attachEvent)  {
    staffing_select.attachEvent('change', setFTEorPctOfMedia);
  }
  var addonSelectors = document.getElementsByClassName('checkmarkSelector');
  for(var j=0; j < addonSelectors.length ; j++){
    if (addonSelectors[j].addEventListener) {
      addonSelectors[j].addEventListener('change', setAddonsValues , {passive: true });
      addonSelectors[j].addEventListener('keyup', setAddonsValues, {passive: true });
    } else if (addonSelectors[j].attachEvent)  {
      addonSelectors[j].attachEvent('change', setAddonsValues);
      addonSelectors[j].attachEvent('keyup', setAddonsValues);
    }
  }
  if (hasAllParams()) {
    setDeliverdScenario();
  } else {
    setBaseScenario();
  }
  setAddonsValues();
  setFTEorPctOfMedia();
  resizeDifference();

  window.addEventListener('reize', resizeDifference, {passive: true});
};

function resizeDifference(){
  var leftCol = document.getElementsByClassName('left-column')[0];
  var middleCol = document.getElementsByClassName('center-column')[0];
  var rightCol = document.getElementsByClassName('right-column')[0];
  var maxH = Math.max.apply(null, [leftCol.offsetHeight, middleCol.offsetHeigt, rightCol.offsetHeigt]);
  resizeHeight(leftCol,maxH);
  resizeHeight(middleCol,maxH);
  resizeHeight(rightCol,maxH);
}

function resizeHeight(elem,height){
  elem.style.height = height + "px";
}

function setQueryString(){
  var input_videoBudgetWeighting = getValueFromElementToFloat('input_videoBudgetWeighting');
  var input_displayBudgetWeighting = getValueFromElementToFloat('input_displayBudgetWeighting');
  var input_mediaCpmDisplayDSP = getValueFromElementToFloat('input_mediaCpmDisplayDSP');
  var input_mediaCpmVideoDSP = getValueFromElementToFloat('input_mediaCpmVideoDSP');
  var input_total = getValueFromElementToFloat('input_total');
  var input_pctOfMediaPbu = getValueFromElementToFloat('input_pctOfMediaPbu');
  var input_ftesDSP = getValueFromElementToFloat('input_ftesDSP');
  var input_ftesPBU = getValueFromElementToFloat('input_ftesPBU');
  var input_ftesQuantity = getValueFromElementToFloat('input_ftesQuantity');
  var input_pctOfMediaDsp = getValueFromElementToFloat('input_pctOfMediaDsp');
  //var input_DMPAddon = getValueFromElementToFloat('input_DMPAddon');
  var selectStaffing = document.getElementById('select_staffing').value;

  var check_DMPAddon = document.getElementById('check_DMPAddon');
  var input_viewabilityBenchmarkDisplay = getValueFromElementToFloat('input_viewabilityBenchmarkDisplay');
  var input_viewabilityBenchmarkVideo = getValueFromElementToFloat('input_viewabilityBenchmarkVideo');
  var input_platformTechFee = getValueFromElementToFloat('platform-tech-fee');

  var staffingType, pbuStaffing;
  if(selectStaffing == 'fte'){
    staffingType = 'fte=true';
    pbuStaffing = 'pbuStaffing=' + input_ftesPBU;
    dspStaffing = 'dspStaffing=' + input_ftesDSP;
    ftesQuantity = 'fteQuantity=' + input_ftesQuantity;
  }
  else{
    staffingType = 'pctOfMedia=true';
    pbuStaffing = 'pbuStaffing='+input_pctOfMediaPbu;
    dspStaffing = 'dspStaffing='+input_pctOfMediaDsp;
    ftesQuantity = 'fteQuantity=' + '0';
  }

  var videoPct = 'videoPct=' + input_videoBudgetWeighting;
  var total = 'total=' + input_total;
  var videoCPM = 'videoCPM=' + input_mediaCpmVideoDSP;
  var displayCPM = 'displayCPM=' + input_mediaCpmDisplayDSP;
  var dmpAddon = 'DMPAddon=' + check_DMPAddon.checked;
  var viewabilityVideo = 'viewabilityVideo=' + input_viewabilityBenchmarkVideo;
  var viewabilityDisplay = 'viewabilityDisplay=' + input_viewabilityBenchmarkDisplay;
  var platformTechFee = 'platformTechFee=' + input_platformTechFee;
  var stateObj = { xaxis: "calculator" };
  var qstring = "?";
  if(getParameterByName('portalId')){
      qstring += 'portalId=436935&template_file_path=custom%2Fpage%2FLanding_Pages%2Fxaxis_value_calculator_v2.html&style_id=hubspot-default-basic&';
  }
    qstring +=
        videoPct + "&" +
        total + "&" +
        staffingType + "&" +
        pbuStaffing + "&" +
        dspStaffing + "&" +
        ftesQuantity + "&" +
        videoCPM + "&" +
        displayCPM + "&" +
        dmpAddon + "&" +
        viewabilityVideo + "&" +
        viewabilityDisplay + "&" +
        platformTechFee;

  history.pushState(stateObj, "", qstring);
}

function setDeliverdScenario(){
  var videoWeight = document.getElementById('input_videoBudgetWeighting');
  var displayWeight = document.getElementById('input_displayBudgetWeighting');
  var totalInput = document.getElementById('input_total');
  var staffingType;
  var dspStaffing;
  var pbuStaffing;
  if(getParameterByName('fte')){
    staffingType = 'fte';
    dspStaffing = document.getElementById('input_ftesDSP');
    pbuStaffing = document.getElementById('input_ftesPBU');
    fteQuantity = document.getElementById('input_ftesQuantity');
  }
  else{
    staffingType = 'pctOfMedia';
    dspStaffing = document.getElementById('input_pctOfMediaDsp');
    pbuStaffing = document.getElementById('input_pctOfMediaPbu');
    fteQuantity = document.getElementById('input_ftesQuantity');
  }
  var selectStaffing = document.getElementById('select_staffing');

  var videoCPM = document.getElementById('input_mediaCpmVideoDSP');
  var displayCPM = document.getElementById('input_mediaCpmDisplayDSP');
  var check_DMPAddon = document.getElementById('check_DMPAddon');
  var input_viewabilityBenchmarkDisplay = document.getElementById('input_viewabilityBenchmarkDisplay');
  var input_viewabilityBenchmarkVideo = document.getElementById('input_viewabilityBenchmarkVideo');
  var input_platformTechFee = document.getElementById('platform-tech-fee');

  videoWeight.value = getParameterByName('videoPct');
  displayWeight.value = 100 - getParameterByName('videoPct');
  totalInput.value = getParameterByName('total');
  selectStaffing.value = staffingType;
  if (staffingType == 'fte'){
    fteQuantity.value = getParameterByName('fteQuantity');
  }else{
    input_ftesQuantity.value = 0;
  }
  pbuStaffing.value = getParameterByName('pbuStaffing');
  dspStaffing.value = getParameterByName('dspStaffing');
  videoCPM.value = getParameterByName('videoCPM');
  displayCPM.value = getParameterByName('displayCPM');
  check_DMPAddon.checked = getParameterByName('DMPAddon') == 'true' ? true : false;
  if(check_DMPAddon.checked){
    input_DMPAddon.value = 20000;
  }
  input_viewabilityBenchmarkVideo.value = getParameterByName('viewabilityVideo');
  input_viewabilityBenchmarkDisplay.value = getParameterByName('viewabilityDisplay');
  input_platformTechFee.value = getParameterByName('platformTechFee');
  setValues();
}

function getParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}

function hasAllParams(){
  var hasParams = false;
  var total = getParameterByName('total');
  var videoPct = getParameterByName('videoPct');
  var videoCPM = getParameterByName('videoCPM');
  var displayCPM = getParameterByName('displayCPM');
  var fte = getParameterByName('fte');
  var fteQuantity = getParameterByName('fteQuantity');
  var pctOfMedia = getParameterByName('pctOfMedia');
  var dspStaffing = getParameterByName('dspStaffing');
  var pbuStaffing = getParameterByName('pbuStaffing');
  var xaxStaffing = getParameterByName('xaxStaffing');
  var viewabilityVideo = getParameterByName('viewabilityVideo');
  var viewabilityDisplay = getParameterByName('viewabilityDisplay');
  if(total &&
              videoPct &&
              videoCPM &&
              displayCPM &&
              (
                (fte && !pctOfMedia) ||
                (!fte && pctOfMedia)
              ) &&
              pbuStaffing &&
              viewabilityVideo &&
              viewabilityDisplay
    ){
    hasParams = true;
  }
  return hasParams;
}
/*
*
*
*
*
*
*
*
*
*

*                                                              */

/*
 *
 *
 *
 *
 * Set Addons tables
 *
 *
 *
 *                                                            */

function setAddonsValues(){
  var check_DMPAddon = document.getElementById('check_DMPAddon');
  var DMPAddon_quantity = document.getElementById('DMPAddon_quantity');
  var input_DMPAddon = document.getElementById('input_DMPAddon');


  var row_addons = document.getElementById('row_addons');
  var row_dmp_addon = document.getElementById('row_dmp_addon');
  var row_cs_addon = document.getElementById('row_cs_addon');
  var numberOfAddons = 0;
  if(check_DMPAddon.checked){
    numberOfAddons += 1;
    row_dmp_addon.style.display = '';
    DMPAddon_quantity.style.display = '';
    input_DMPAddon.value = 20000;
  }else{
    DMPAddon_quantity.style.display = 'none';
    row_dmp_addon.style.display = 'none';
    input_DMPAddon.value = 0;
  }
  if(numberOfAddons > 0){
    row_addons.style.display = '';
  }
  else{
    row_addons.style.display = 'none';
  }
  setWeightings();
}

/*
 *
 *
 *
 *
 * Set FTE or PCT of Media Selection
 *
 *
 *
 *                                                            */

function setFTEorPctOfMedia(){
  var row_staffing = document.getElementById('row_staffing');
  var row_FTE = document.getElementById('row_FTE');
  var row_PctOfMedia =document.getElementById('row_PctOfMedia');
  var input_pctOfMediaPbu = document.getElementById('input_pctOfMediaPbu');
  var input_ftesDSP = document.getElementById('input_ftesDSP');
  var input_ftesPBU = document.getElementById('input_ftesPBU');
  var input_ftesQuantity = document.getElementById('input_ftesQuantity');
  var input_pctOfMediaDsp = document.getElementById('input_pctOfMediaDsp');
  var select_staffing = document.getElementById('select_staffing');
  var row_fte_inputs = document.getElementById('row_fte_inputs');
  var row_PctOfMedia_inputs = document.getElementById('row_PctOfMedia_inputs');
  if(select_staffing.value === 'fte'){
    input_pctOfMediaPbu.value = 0;
    input_pctOfMediaDsp.value = 0;
    input_ftesQuantity.value = 1;
    input_ftesDSP.value = 75000;
    input_ftesPBU.value = 75000;
    row_FTE.style.display = "";
    row_PctOfMedia.style.display = 'none';
    row_staffing.style.display = '';
    row_fte_inputs.style.display = '';
    row_PctOfMedia_inputs.style.display = 'none';
  }
  else if(select_staffing.value === 'pctOfMedia'){
    input_ftesDSP.value = 0;
    input_ftesPBU.value = 0;
    input_ftesQuantity.value = 0;
    input_pctOfMediaPbu.value = 12;
    input_pctOfMediaDsp.value = 12;
    row_FTE.style.display = 'none';
    row_PctOfMedia.style.display = '';
    row_staffing.style.display = '';
    row_fte_inputs.style.display = 'none';
    row_PctOfMedia_inputs.style.display = '';
  }
  else{
    input_pctOfMediaPbu.value = 0;
    input_pctOfMediaDsp.value = 0;
    input_ftesDSP.value = 0;
    input_ftesPBU.value = 0;
    row_FTE.style.display = 'none';
    row_PctOfMedia.style.display = 'none';
    row_staffing.style.display = 'none';
    row_fte_inputs.style.display = 'none';
    row_PctOfMedia_inputs.style.display = 'none';
  }
  setWeightings();
}

/*
 *
 *
 *checks to see if weight balance changes,
 *if yes reset other then set all values
 *based on current table representation
 *
 *
 *
 *                                                            */

function setWeightings(){
  var that = this;
  if(that.id == 'input_videoBudgetWeighting'){
    document.getElementById('input_displayBudgetWeighting').value = 100 - that.value;
  }
  else if(that.id == 'input_displayBudgetWeighting'){
    document.getElementById('input_videoBudgetWeighting').value = 100 - that.value;
  }
  setValues();
}


/*
 *
 *
 *
 *
 *initialize values on load to excel chart numbers
 *
 *
 *
 *                                                            */
function setBaseScenario(){
  document.getElementById('input_total').value = constants.initializers.input_total_init;
  document.getElementById('select_staffing').value = constants.initializers.select_staffing_init;
  document.getElementById('input_pctOfMediaPbu').value = constants.initializers.input_pctOfMediaPbu_init;
  document.getElementById('input_pctOfMediaDsp').value = constants.initializers.input_pctOfMediaPbu_init;
  document.getElementById('input_mediaCpmVideoDSP').value = constants.initializers.input_mediaCpmVideoDSP_init;
  document.getElementById('input_mediaCpmDisplayDSP').value = constants.initializers.input_mediaCpmDisplayDSP_init;
  document.getElementById('input_viewabilityBenchmarkDisplay').value = constants.viewabilityBenchmarkDisplay;
  document.getElementById('input_viewabilityBenchmarkVideo').value = constants.viewabilityBenchmarkVideo;
  document.getElementById('platform-tech-fee').value = constants.initializers.pbuTechCostPct;
  setValues();
}



/*
 *
 *
 *
 *
 * sets all table values
 *
 *
 *
 *                                                            */
function setValues(){

  //gets values from user inputs.
  var input_videoBudgetWeighting = getValueFromElementToFloat('input_videoBudgetWeighting');
  var input_displayBudgetWeighting = getValueFromElementToFloat('input_displayBudgetWeighting');
  var input_mediaCpmDisplayDSP = getValueFromElementToFloat('input_mediaCpmDisplayDSP');
  var input_mediaCpmVideoDSP = getValueFromElementToFloat('input_mediaCpmVideoDSP');
  var input_total = getValueFromElementToFloat('input_total');
  var input_pctOfMediaPbu = getValueFromElementToFloat('input_pctOfMediaPbu');
  var input_ftesDSP = getValueFromElementToFloat('input_ftesDSP');
  var input_ftesPBU = getValueFromElementToFloat('input_ftesPBU');
  var input_ftesQuantity = getValueFromElementToFloat('input_ftesQuantity');
  var input_pctOfMediaDsp = getValueFromElementToFloat('input_pctOfMediaDsp');
  var input_DMPAddon = getValueFromElementToFloat('input_DMPAddon');
  var input_viewabilityBenchmarkDisplay = getValueFromElementToFloat('input_viewabilityBenchmarkDisplay');
  var input_viewabilityBenchmarkVideo = getValueFromElementToFloat('input_viewabilityBenchmarkVideo');
  var input_techCosts = getValueFromElementToFloat('platform-tech-fee');
  //gets fields to enter calculated values
  // var viewabilityBenchmarkDisplay = document.getElementById('input_viewabilityBenchmarkDisplay');
  // var viewabilityBenchmarkVideo = document.getElementById('input_viewabilityBenchmarkVideo');
  var workingMediaBudgetDsp = document.getElementById('workingMediaBudgetDsp');
  var workingMediaBudgetPbu = document.getElementById('workingMediaBudgetPbu');
  var workingMediaBudgetXax = document.getElementById('workingMediaBudgetXax');
  var mediaCpmDisplayDsp = document.getElementById('mediaCpmDisplayDsp');
  var mediaCpmVideoDsp = document.getElementById('mediaCpmVideoDsp');
  var mediaCpmDisplayXaxis  = document.getElementById('mediaCpmDisplayXaxis');
  var mediaCpmDisplayPBU  = document.getElementById('mediaCpmDisplayPBU');
  var mediaCpmVideoPBU  = document.getElementById('mediaCpmVideoPBU');
  var mediaCpmVideoXaxis  = document.getElementById('mediaCpmVideoXaxis');
  var impressionsTotalDSP  = document.getElementById('impressionsTotalDSP');
  var impressionsTotalPBU  = document.getElementById('impressionsTotalPBU');
  var impressionsTotalXaxis  = document.getElementById('impressionsTotalXaxis');
  var impressionsViewableDSP  = document.getElementById('impressionsViewableDSP');
  var impressionsViewablePBU  = document.getElementById('impressionsViewablePBU');
  var impressionsViewableXaxis  = document.getElementById('impressionsViewableXaxis');
  var dataCostPbu = document.getElementById('dataCostPbu');
  var verificationAdvertisingPBU = document.getElementById('verificationAdvertisingPBU');
  var executionCostsDsp = document.getElementById('executionCostsDsp');
  var executionCostsPbu = document.getElementById('executionCostsPbu');
  var executionCostsXaxis = document.getElementById('executionCostsXaxis');
  var totalDsp = document.getElementById('totalDsp');
  var totalPbu = document.getElementById('totalPbu');
  var totalXaxis = document.getElementById('totalXaxis');
  var costNonXaxisPartner = document.getElementById('costNonXaxisPartner');
  var costNonXaxisCurrentWM = document.getElementById('costNonXaxisCurrentWM');
  var nonXaxisPartnerPctDiff = document.getElementById('nonXaxisPartnerPctDiff');
  var techCostPBU = document.getElementById('techCostPbu');
  var dspInternalSpend = document.getElementById('dspInternalSpend');
  var dmpAddonDsp = document.getElementById('dmpAddonDsp');
  var dmpaddonPbu = document.getElementById('dmpaddonPbu');
  //var dmpaddonXaxis = document.getElementById('dmpaddonXaxis');
  var ftesDSP = document.getElementById('ftesDSP');
  var ftesPBU = document.getElementById('ftesPBU');
  var pctOfMediaDSP = document.getElementById('pctOfMediaDSP');
  var pctOfMediaPbu = document.getElementById('pctOfMediaPbu');
  var impressionsVsPBU = document.getElementById('impressionsVsPBU');
  var viewableImpressionsVsPBU = document.getElementById('viewableImpressionsVsPBU');
  var impressionsVsDSP = document.getElementById('impressionsVsDSP');
  var viewableImpressionsVsDSP = document.getElementById('viewableImpressionsVsDSP');
  var moreImpressionsDSPPct = document.getElementById('moreImpressionsDSPPct');
  var moreImpressionsPBUPct = document.getElementById('moreImpressionsPBUPct');
  var moreImpressionsDSPPct2 = document.getElementById('moreImpressionsDSPPct2');
  var moreImpressionsPBUPct2 = document.getElementById('moreImpressionsPBUPct2');

  //set values for calcs
  var viewabilityBenchmarkVideo_value = input_viewabilityBenchmarkVideo;
  var viewabilityBenchmarkDisplay_value = input_viewabilityBenchmarkDisplay;
  var dataCostDsp_value = 0;
  var dataCostXaxis_value = 0;
  var DMPAddon_value = input_DMPAddon;
  var dmpAddonDsp_value = DMPAddon_value * constants.addons.DMPAddon.dsp;
  var dmpaddonPbu_value = DMPAddon_value * constants.addons.DMPAddon.pbu;
  // var dmpaddonXaxis_value = DMPAddon_value * constants.addons.DMPAddon.xaxis;
  var totalDsp_value = input_total;
  var totalPbu_value = input_total;
  var totalXaxis_value = input_total;
  var pctOfMediaPbu_value = (input_pctOfMediaPbu/100) * totalPbu_value;
  var videoBudgetWeighting_value = input_videoBudgetWeighting;
  var displayBudgetWeighting_value = input_displayBudgetWeighting;
  var ftesDSP_value = input_ftesDSP * input_ftesQuantity;
  var ftesPbu_value = input_ftesPBU * input_ftesQuantity;
  var pctOfMediaDsp_value = (input_pctOfMediaDsp/100) * totalDsp_value;
  var techCostDSP_value = 0;
  var techCostXaxis_value = 0;
  var verificationAdvertisingXaxis_value = 0;
  var verificationAdvertisingDsp_value = 0;
  var mediaCpmDisplayDSP_value = input_mediaCpmDisplayDSP;
  var mediaCpmVideoDSP_value = input_mediaCpmVideoDSP;
  var dspInternalSpend_value = input_total * constants.dspInternalSpendPct;

  //set values by calcin'
  var techCostPbu_value = input_total * input_techCosts/100;
  var dataCostPbu_value = totalPbu_value * constants.dataCostPBUPct;
  var verificationAdvertisingPBU_value = totalPbu_value * constants.verificationAdvertisingPBUPct;
  var mediaCpmDisplayXaxis_value = mediaCpmDisplayDSP_value * constants.displayCPMDiscountPct;
  var mediaCpmDisplayPBU_value = mediaCpmDisplayDSP_value * constants.displayCPMDiscountPct;
  var mediaCpmVideoPBU_value = mediaCpmVideoDSP_value * constants.videoCPMDiscountPct;
  var mediaCpmVideoXaxis_value = mediaCpmVideoDSP_value * constants.videoCPMDiscountPct;
  var dspAddon_total = dmpAddonDsp_value;
  var pbuAddon_total = dmpaddonPbu_value;
  var xaxisAddon_total = 0;

  // TODO set pct commission costs properly
  var executionCostsDsp_value = pctOfMediaDsp_value +
                                techCostDSP_value +
                                dataCostDsp_value +
                                verificationAdvertisingDsp_value +
                                ftesDSP_value +
                                dspInternalSpend_value +
                                dspAddon_total;

  var executionCostsPbu_value = pctOfMediaPbu_value +
                                techCostPbu_value +
                                dataCostPbu_value +
                                verificationAdvertisingPBU_value +
                                ftesPbu_value +
                                pbuAddon_total;

  var executionCostsXaxis_value = xaxisAddon_total;
  var workingMediaBudgetPbu_value = totalPbu_value - executionCostsPbu_value;
  var workingMediaBudgetDsp_value = totalDsp_value - executionCostsDsp_value;
  var workingMediaBudgetXax_value = totalXaxis_value - executionCostsXaxis_value;

  var impressionsTotalDSP_value =
                                  (((workingMediaBudgetDsp_value/mediaCpmDisplayDSP_value)*
                                  1000*
                                  videoBudgetWeighting_value)/
                                  viewabilityBenchmarkDisplay_value) +
                                  (((workingMediaBudgetDsp_value/mediaCpmVideoDSP_value)*
                                  1000*
                                  displayBudgetWeighting_value)/
                                  viewabilityBenchmarkVideo_value);

  var impressionsTotalPBU_value =
                                  (((workingMediaBudgetPbu_value/mediaCpmDisplayPBU_value)*
                                  1000*
                                  videoBudgetWeighting_value)/
                                  viewabilityBenchmarkDisplay_value) +
                                  (((workingMediaBudgetPbu_value/mediaCpmVideoPBU_value)*
                                  1000*
                                  displayBudgetWeighting_value)/
                                  viewabilityBenchmarkVideo_value);

  var impressionsTotalXaxis_value =
                                  (((workingMediaBudgetXax_value/mediaCpmDisplayXaxis_value)*
                                  1000*
                                  videoBudgetWeighting_value)/
                                  viewabilityBenchmarkDisplay_value) +
                                  (((workingMediaBudgetXax_value/mediaCpmVideoXaxis_value)*
                                  1000*
                                  displayBudgetWeighting_value)/
                                  viewabilityBenchmarkVideo_value);

  var impressionsViewableDSP_value =
                                  ((workingMediaBudgetDsp_value/mediaCpmDisplayDSP_value)*
                                  1000*
                                  videoBudgetWeighting_value) +
                                  ((workingMediaBudgetDsp_value/mediaCpmVideoDSP_value)*
                                  1000*
                                  displayBudgetWeighting_value);

  var impressionsViewablePBU_value =
                                  ((workingMediaBudgetPbu_value/mediaCpmDisplayPBU_value)*
                                  1000*
                                  videoBudgetWeighting_value) +
                                  ((workingMediaBudgetPbu_value/mediaCpmVideoPBU_value)*
                                  1000*
                                  displayBudgetWeighting_value);

  var impressionsViewableXaxis_value =
                                  ((workingMediaBudgetXax_value/mediaCpmDisplayXaxis_value)*
                                  1000*
                                  videoBudgetWeighting_value) +
                                  ((workingMediaBudgetXax_value/mediaCpmVideoXaxis_value)*
                                  1000*
                                  displayBudgetWeighting_value);

  var costNonXaxisPartner_value = (((impressionsViewableXaxis_value - impressionsViewablePBU_value)/1000) * mediaCpmDisplayDSP_value)/100;
  var costNonXaxisDSPPartner_value = (((impressionsViewableXaxis_value - impressionsViewableDSP_value)/1000) * mediaCpmDisplayDSP_value)/100;
  var costNonXaxisCurrentWM_value = costNonXaxisPartner_value + workingMediaBudgetPbu_value;
  var nonXaxisPartnerPctDiff_value = costNonXaxisCurrentWM_value / workingMediaBudgetPbu_value * 100;

  //display formatting
  if(impressionsTotalDSP_value == Infinity || isNaN(impressionsTotalDSP_value)){
    impressionsTotalDSP_value = 0;
  }
  if(impressionsTotalPBU_value == Infinity || isNaN(impressionsTotalPBU_value)){
    impressionsTotalPBU_value = 0;
  }
  if(impressionsTotalXaxis_value == Infinity || isNaN(impressionsTotalXaxis_value)){
    impressionsTotalXaxis_value = 0;
  }
  if(impressionsViewableDSP_value == Infinity || isNaN(impressionsViewableDSP_value)){
    impressionsViewableDSP_value = 0;
  }
  if(impressionsViewablePBU_value == Infinity || isNaN(impressionsViewablePBU_value)){
    impressionsViewablePBU_value = 0;
  }
  if(impressionsViewableXaxis_value == Infinity || isNaN(impressionsViewableXaxis_value)){
    impressionsViewableXaxis_value = 0;
  }

  //set element text to calculated values
  ftesDSP.innerText = numberForDisplay$(input_ftesDSP * input_ftesQuantity);
  ftesPBU.innerText = numberForDisplay$(input_ftesPBU * input_ftesQuantity);
  pctOfMediaDSP.innerText = numberForDisplayPct(input_pctOfMediaDsp);
  pctOfMediaPbu.innerText = numberForDisplayPct(input_pctOfMediaPbu);
  input_viewabilityBenchmarkDisplay.value = numberForDisplayReg(viewabilityBenchmarkDisplay_value);
  input_viewabilityBenchmarkVideo.value = numberForDisplayReg(viewabilityBenchmarkVideo_value);
  mediaCpmDisplayXaxis.innerText = numberForDisplay$(mediaCpmDisplayXaxis_value);
  mediaCpmDisplayPBU.innerText = numberForDisplay$(mediaCpmDisplayPBU_value);
  mediaCpmVideoPBU.innerText = numberForDisplay$(mediaCpmVideoPBU_value);
  mediaCpmVideoXaxis.innerText = numberForDisplay$(mediaCpmVideoXaxis_value);
  mediaCpmDisplayDsp.innerText = numberForDisplay$(mediaCpmDisplayDSP_value);
  mediaCpmVideoDsp.innerText = numberForDisplay$(mediaCpmVideoDSP_value);
  totalDsp.innerText = numberForDisplay$(totalDsp_value);
  totalPbu.innerText = numberForDisplay$(totalPbu_value);
  totalXaxis.innerText = numberForDisplay$(totalXaxis_value);
  dataCostPbu.innerText = numberForDisplay$(dataCostPbu_value);
  verificationAdvertisingPBU.innerText = numberForDisplay$(verificationAdvertisingPBU_value);
  dmpAddonDsp.innerText = numberForDisplay$(dmpAddonDsp_value);
  dmpaddonPbu.innerText = numberForDisplay$(dmpaddonPbu_value);
  dmpaddonXaxis.innerText = "N/A";
    //numberForDisplay$(dmpaddonXaxis_value);
    //numberForDisplay$(dvdAddonXaxis_value);
  executionCostsDsp.innerText = numberForDisplay$(executionCostsDsp_value);
  executionCostsPbu.innerText = numberForDisplay$(executionCostsPbu_value);
  executionCostsXaxis.innerText = numberForDisplay$(executionCostsXaxis_value);
  workingMediaBudgetDsp.innerText = numberForDisplay$(workingMediaBudgetDsp_value);
  workingMediaBudgetPbu.innerText = numberForDisplay$(workingMediaBudgetPbu_value);
  workingMediaBudgetXax.innerText = numberForDisplay$(workingMediaBudgetXax_value);
  impressionsTotalDSP.innerText = numberForDisplayReg(impressionsTotalDSP_value);
  impressionsTotalPBU.innerText =  numberForDisplayReg(impressionsTotalPBU_value);
  impressionsTotalXaxis.innerText =  numberForDisplayReg(impressionsTotalXaxis_value);
  impressionsViewableDSP.innerText = numberForDisplayReg(impressionsViewableDSP_value/100);
  impressionsViewablePBU.innerText =  numberForDisplayReg(impressionsViewablePBU_value/100);
  impressionsViewableXaxis.innerText =  numberForDisplayReg(impressionsViewableXaxis_value/100);
  costNonXaxisPartner.innerText = numberForDisplay$(costNonXaxisPartner_value);
  costNonXaxisDSPPartner.innerText =
    numberForDisplay$(costNonXaxisDSPPartner_value);
  //costNonXaxisCurrentWM.innerText = numberForDisplay$(costNonXaxisCurrentWM_value);
  //nonXaxisPartnerPctDiff.innerText = numberForDisplayPct(nonXaxisPartnerPctDiff_value);
  techCostPBU.innerText =  numberForDisplay$(techCostPbu_value);
  dspInternalSpend.innerText = numberForDisplay$(dspInternalSpend_value);
  impressionsVsPBU.innerText = numberForDisplayReg(
    impressionsTotalXaxis_value - impressionsTotalPBU_value
  );
  viewableImpressionsVsPBU.innerText = numberForDisplayReg(
    (impressionsViewableXaxis_value- impressionsViewablePBU_value)/100
  );
  impressionsVsDSP.innerText = numberForDisplayReg(
    impressionsTotalXaxis_value - impressionsTotalDSP_value
  );
  viewableImpressionsVsDSP.innerText = numberForDisplayReg(
    (impressionsViewableXaxis_value - impressionsViewableDSP_value)/100
  );
  moreImpressionsDSPPct2.innerText = moreImpressionsDSPPct.innerText = (
    ((impressionsTotalXaxis_value - impressionsTotalDSP_value) /
    impressionsTotalDSP_value) *
    100).toFixed(0) + '%';
  moreImpressionsPBUPct2.innerText = moreImpressionsPBUPct.innerText = (
    ((impressionsTotalXaxis_value - impressionsTotalPBU_value) /
    impressionsTotalPBU_value) *
    100).toFixed(0) + '%';
  setQueryString();
}

/*
 *
 *
 *
 *
 * format for display, $.00
 *
 *
 *
 *                                                            */
function numberForDisplay$(inputNum){
  if(isNaN(inputNum)){
    return "$"+parseFloat(0).toLocaleString(undefined, {
                                              minimumFractionDigits: 2,
                                              maximumFractionDigits: 2
                                            });
  }
  else{
    return "$"+parseFloat(inputNum).toLocaleString(undefined, {
                                                minimumFractionDigits: 2,
                                                maximumFractionDigits: 2
                                              });
  }
}

/*
 *
 *
 *
 *
 * format for display, no fractions, with commas
 *
 *
 *
 *                                                            */
function numberForDisplayReg(inputNum){
  if(isNaN(inputNum)){
    return parseFloat(0).toFixed(0);
  }
  return numberWithCommas(parseFloat(inputNum).toFixed(0));
}

/*
 *
 *
 *
 *
 * format for display, % signs, no decimals
 *
 *
 *
 *                                                            */
function numberForDisplayPct(inputNum){
  if(isNaN(inputNum)){
    return parseFloat(0).toFixed(2) + '%';
  }
  return parseFloat(inputNum).toFixed(2) + '%';
}

/*
 *
 *
 *
 *
 * gets values as a float from an input , or 0 if 0/NAN
 *
 *
 *
 *                                                            */
function getValueFromElementToFloat(elem){
  elem = document.getElementById(elem);
  elem_value = parseFloat(elem.value).toFixed(2);
  if(elem_value === '0' || isNaN(elem_value)){
    return Number(0);
  }
  else{
    return Number(elem_value);
  }
}

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
