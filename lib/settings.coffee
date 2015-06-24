path       = require 'path'
ConfigPlus = require 'atom-config-plus'

config =
  root:
    order: 1
    type: 'string'
    default: path.join(atom.config.get('core.projectHome'), "phrase")
    description: "Root directory of your phrase buffer"
  clearSelection:
    order: 2
    type: 'boolean'
    default: true
    description: "Clear original selection"
  pasteTo:
    order: 3
    type: 'string'
    default: "top"
    enum: ["bottom", "top", "here"]
    description: "Where selected phrase is pasted in phrase file."
  select:
    order: 4
    type: 'boolean'
    default: true
    description: "Select pasted text"
  split:
    order: 5
    type: 'string'
    default: 'right'
    enum: ["none", "left", "right" ]
    description: "Where phrase buffer opend"
  searchAllPanes:
    order: 6
    type: 'boolean'
    default: false
    description: "Open existing phrase buffer if exists"

module.exports = new ConfigPlus 'phrase', config
