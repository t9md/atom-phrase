path       = require 'path'
ConfigPlus = require 'atom-config-plus'

config =
  root:
    order: 1
    type: 'string'
    default: path.join(atom.config.get('core.projectHome'), "phrase")
    description: "Root directory of your phrase buffer"
  basename:
    order: 2
    type: 'string'
    default: 'phrase'
    description: "Basename of phrase buffer"
  clearSelection:
    order: 3
    type: 'boolean'
    default: true
    description: "Clear original selection"
  pasteTo:
    order: 4
    type: 'string'
    default: "top"
    enum: ["bottom", "top", "here"]
    description: "Where selected text is pasted."
  select:
    order: 5
    type: 'boolean'
    default: true
    description: "Select pasted text"
  # autoIndent:
  #   order: 6
  #   type: 'boolean'
  #   default: false
  #   description: "Indent pasted text"
  split:
    order: 7
    type: 'string'
    default: 'right'
    enum: ["none", "left", "right" ]
    description: "Where phrase buffer opend"
  searchAllPanes:
    order: 8
    type: 'boolean'
    default: false
    description: "Open existing phrase buffer if exists"

module.exports = new ConfigPlus 'phrase', config
