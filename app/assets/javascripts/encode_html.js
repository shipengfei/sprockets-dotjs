window.encodeHTML=(function encodeHTMLSource() {
    var encodeHTMLRules = { "&": "&#38;", "<": "&#60;", ">": "&#62;", '"': '&#34;', "'": '&#39;', "/": '&#47;' },
        matchHTML = /&(?!#?\w+;)|<|>|"|'|\//g;
    return function(code) {
        return code ? code.toString().replace(matchHTML, function(m) {return encodeHTMLRules[m] || m;}) : '';
    };
}());