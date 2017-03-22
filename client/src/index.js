'use strict';

require('./index.html');

require('./app.css');


var Elm = require('./Main.elm');

var mountNode = document.getElementsByTagName('main')[0];

var app = Elm.Main.embed(mountNode);
