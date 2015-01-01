expect = require('indeed').expect
Sequence = require('../lib/sequence')

describe 'letters', ->
  Given -> @subject = require '../lib/letters'

  describe 'next', ->
    context 'no options', ->
      Given -> @letters = new @subject()
      When -> @l1 = @letters.next()
      And -> @l2 = @letters.next()
      Then -> expect(@l1).to.equal 'a'
      And -> expect(@l2).to.equal 'b'

    context 'with startAt', ->
      context 'single letter', ->
        Given -> @letters = new @subject
          startAt: 'z'
        When -> @l1 = @letters.next()
        And -> @l2 = @letters.next()
        Then -> expect(@l1).to.equal 'z'
        And -> expect(@l2).to.equal 'aa'

      context 'multiple letters', ->
        Given -> @letters = new @subject
          startAt: 'abc'
        When -> @l1 = @letters.next()
        And -> @l2 = @letters.next()
        Then -> expect(@l1).to.equal 'abc'
        And -> expect(@l2).to.equal 'abd'
        And -> expect(@letters.sequences.length).to.equal 3

    context 'with useNumbers', ->
      Given -> @letters = new @subject
        useNumbers: true
        startAt: 'z'
      When -> @l1 = @letters.next()
      And -> @l2 = @letters.next()
      Then -> expect(@l1).to.equal 'z'
      And -> expect(@l2).to.equal '0'

    context 'with numbersFirst', ->
      context 'without useNumbers', ->
        Given -> @letters = new @subject
          numbersFirst: true
        When -> @l1 = @letters.next()
        And -> @l2 = @letters.characters[10]
        Then -> expect(@l1).to.equal '0'
        And -> expect(@l2).to.equal 'a'

      context 'with useNumbers', ->
        Given -> @letters = new @subject
          useNumbers: true
          numbersFirst: true
        When -> @l1 = @letters.next()
        And -> @l2 = @letters.characters[10]
        Then -> expect(@l1).to.equal '0'
        And -> expect(@l2).to.equal 'a'

    context 'multiple levels', ->
      context 'no roll over', ->
        Given -> @letters = new @subject()
        Given -> @s1 = new Sequence(@letters.characters, 0)
        Given -> @s2 = new Sequence(@letters.characters, 0)
        Given -> @s3 = new Sequence(@letters.characters, 1)
        Given -> @s4 = new Sequence(@letters.characters, 2)
        Given -> @s5 = new Sequence(@letters.characters, 3)
        Given -> @letters.sequences = [@s1, @s2, @s3, @s4, @s5]
        When -> @l1 = @letters.next()
        And -> @l2 = @letters.next()
        Then -> expect(@l1).to.equal 'aabcd'
        And -> expect(@l2).to.equal 'aabce'

      context 'roll over', ->
        Given -> @letters = new @subject()
        Given -> @s1 = new Sequence(@letters.characters, 0)
        Given -> @s2 = new Sequence(@letters.characters, 0)
        Given -> @s3 = new Sequence(@letters.characters, 1)
        Given -> @s4 = new Sequence(@letters.characters, 2)
        Given -> @s5 = new Sequence(@letters.characters, 25)
        Given -> @letters.sequences = [@s1, @s2, @s3, @s4, @s5]
        When -> @l1 = @letters.next()
        And -> @l2 = @letters.next()
        Then -> expect(@l1).to.equal 'aabcz'
        And -> expect(@l2).to.equal 'aabda'

      context 'multi roll over', ->
        Given -> @letters = new @subject()
        Given -> @s1 = new Sequence(@letters.characters, 0)
        Given -> @s2 = new Sequence(@letters.characters, 0)
        Given -> @s3 = new Sequence(@letters.characters, 1)
        Given -> @s4 = new Sequence(@letters.characters, 25)
        Given -> @s5 = new Sequence(@letters.characters, 25)
        Given -> @letters.sequences = [@s1, @s2, @s3, @s4, @s5]
        When -> @l1 = @letters.next()
        And -> @l2 = @letters.next()
        Then -> expect(@l1).to.equal 'aabzz'
        And -> expect(@l2).to.equal 'aacaa'
