var Sequence = module.exports = function Sequence(characters, start) {
  this.characters = characters;
  this.start = start;
  this.current = start;
};

Sequence.prototype.hasNext = function() {
  return Boolean(this.characters[this.current]);
};

Sequence.prototype.getNext = function() {
  return this.characters[this.current];
};

Sequence.prototype.increment = function() {
  this.current++;
  return this;
};

Sequence.prototype.rollOver = function() {
  this.current = 0;
  return this;
};
