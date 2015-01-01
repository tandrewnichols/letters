var Sequence = require('./sequence');
var util = require('util');
var letters = 'abcdefghijklmnopqrstuvwxyz';
var numbers = '0123456789';

var last = function(arr) {
  return arr[arr.length - 1];
};

var Letters = module.exports = function Letters(config) {
  var self = this;
  self.characters = letters.split('');
  config = config || {};
  if (config.useNumbers || config.numbersFirst) {
    if (config.numbersFirst) {
      self.characters = numbers.split('').concat(self.characters);
    } else {
      self.characters = self.characters.concat(numbers.split(''));
    }
  }
  
  self.sequences = [];
  (config.startAt || self.characters[0]).split('').forEach(function(character) {
    self.sequences.push( new Sequence(self.characters, self.characters.indexOf(character)) ); 
  });
};

Letters.prototype.next = function() {
  var index = this.firstWithNext();
  var str = '';
  this.sequences.forEach(function(sequence, i) {
    str += sequence.getNext();
    if (i >= index) {
      sequence.increment();
    }
  });
  return str;
};

Letters.prototype.firstWithNext = function() {
  for (var i = this.sequences.length - 1; i > -1; i--) {
    var sequence = this.sequences[i];
    if (sequence.hasNext()) {
      return i;
    } else {
      sequence.rollOver();
      if (this.sequences[i - 1]) {
        this.sequences[i - 1].increment();
      } else {
        this.sequences.push( new Sequence(this.characters, 0) );
      }
    }
  }
  return 0;
};
