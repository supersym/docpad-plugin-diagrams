#!/usr/bin/env coffee

encode64 = (data) ->
  r = ""
  i = 0
  while i < data.length
    if i + 2 is data.length
      r += append3bytes(data.charCodeAt(i), data.charCodeAt(i + 1), 0)
    else if i + 1 is data.length
      r += append3bytes(data.charCodeAt(i), 0, 0)
    else
      r += append3bytes(data.charCodeAt(i), data.charCodeAt(i + 1), data.charCodeAt(i + 2))
    i += 3
  r
append3bytes = (b1, b2, b3) ->
  c1 = b1 >> 2
  c2 = ((b1 & 0x3) << 4) | (b2 >> 4)
  c3 = ((b2 & 0xF) << 2) | (b3 >> 6)
  c4 = b3 & 0x3F
  r = ""
  r += encode6bit(c1 & 0x3F)
  r += encode6bit(c2 & 0x3F)
  r += encode6bit(c3 & 0x3F)
  r += encode6bit(c4 & 0x3F)
  r
encode6bit = (b) ->
  return String.fromCharCode(48 + b)  if b < 10
  b -= 10
  return String.fromCharCode(65 + b)  if b < 26
  b -= 26
  return String.fromCharCode(97 + b)  if b < 26
  b -= 26
  return "-"  if b is 0
  return "_"  if b is 1
  "?"
done_deflating = (e) ->
  $("im").src = "http://www.plantuml.com/plantuml/img/" + encode64(e.data)
compress = (s) ->
  
  #UTF8
  s = unescape(encodeURIComponent(s))
  if deflater
    if deflater.port and deflater.port.postMessage
      deflater.port.postMessage s
    else
      deflater.postMessage s
  else
    setTimeout (->
      done_deflating data: deflate(s)
    ), 100
$ = (id) ->
  document.getElementById id

deflater = window.SharedWorker and new SharedWorker("rawdeflate.js")
if deflater
  deflater.port.addEventListener "message", done_deflating, false
  deflater.port.start()
else if window.Worker
  deflater = new Worker("rawdeflate.js")
  deflater.onmessage = done_deflating
