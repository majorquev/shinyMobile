// Input binding
var f7LoginBinding = new Shiny.InputBinding();

$.extend(f7LoginBinding, {

  initialize: function(el) {
    // feed the create method
    var data = {};
    data.el = '#' + $(el).attr("id");
    data.on = {
      opened: function () {
        $(el).trigger('shown');
      }
    };
    var l = app.loginScreen.create(data);
    // the login page should automatically open when inserted
    l.open();
  },

  find: function(scope) {
    return $(scope).find(".login-screen");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    var l = app.loginScreen.get($(el));
    return l.opened;
  },

  // see updateF7Login
  receiveMessage: function(el, data) {
    var l = app.loginScreen.get($(el));
    if (l.opened) {
      l.close();
    } else {
      l.open();
    }
  },

  subscribe: function(el, callback) {
    $(el).on("loginscreen:opened.f7LoginBinding loginscreen:closed.f7LoginBinding", function(e) {
      callback();
    });
  },

  unsubscribe: function(el) {
    $(el).off(".f7LoginBinding");
  }
});

Shiny.inputBindings.register(f7LoginBinding);
