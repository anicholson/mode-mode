'use strict';

require('./index.html');


var Elm = require('./Main.elm');

var mountNode = document.getElementsByTagName('main')[0];

var app = Elm.Main.embed(mountNode);
