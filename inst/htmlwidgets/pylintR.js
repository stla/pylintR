HTMLWidgets.widget({
  name: "pylintR",

  type: "output",

  factory: function (el, width, height) {

    return {
      renderValue: function (x) {
        el.innerHTML = decodeURI(x.html);
      },

      resize: function (width, height) {

      }
    };
  }
});
