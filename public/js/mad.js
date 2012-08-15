var Mad = function () {
    this.replacements = {};
};

Mad.prototype.loop = function (sentence, callback) {
    var v, vn, vl;
    var vars = sentence.match(/\{\w+\}/g);
    var varsl = vars ? vars.length : 0;
    while(varsl--) {
        v = vars[varsl];
        vn = v.replace(/[{}]/g, '');
        vl = this.replacements[vn];
        if (vl && vl.length) {
            callback(v, vl);
        }
    }
};

Mad.prototype.get = function (sentence) {
    var ri;
    this.loop(sentence, function (v, vl) {
        ri = Math.floor(Math.random() * vl.length);
        sentence = sentence.replace(v, vl[ri]);
    });
    return sentence;
};

Mad.prototype.combos = function (sentence) {
    var totals = 1;
    this.loop(sentence, function (v, vl) {
        totals *= vl.length;
    });
    return totals;
};