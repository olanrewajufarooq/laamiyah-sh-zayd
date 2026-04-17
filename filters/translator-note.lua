local function has_class(el, class_name)
  return el.classes and el.classes:includes(class_name)
end

local function build_note_blocks(content)
  local blocks = pandoc.List(content)

  if #blocks == 0 then
    return pandoc.List({
      pandoc.Para({
        pandoc.Emph({ pandoc.Str("Translator's note:") })
      })
    })
  end

  local first = blocks[1]
  if first.t == "Para" or first.t == "Plain" then
    local inlines = pandoc.List({
      pandoc.Emph({ pandoc.Str("Translator's note:") }),
      pandoc.Space(),
    })

    for _, inline in ipairs(first.content) do
      table.insert(inlines, inline)
    end

    if first.t == "Para" then
      blocks[1] = pandoc.Para(inlines)
    else
      blocks[1] = pandoc.Plain(inlines)
    end
  else
    blocks:insert(1, pandoc.Para({
      pandoc.Emph({ pandoc.Str("Translator's note:") })
    }))
  end

  return blocks
end

function Pandoc(doc)
  local out = pandoc.List()

  for _, block in ipairs(doc.blocks) do
    if block.t == "Div" and has_class(block, "translator-note") then
      local note = pandoc.Note(build_note_blocks(block.content))
      local prev = out[#out]

      if prev and (prev.t == "Para" or prev.t == "Plain") then
        table.insert(prev.content, note)
        out[#out] = prev
      else
        out:insert(pandoc.Para({ note }))
      end
    else
      out:insert(block)
    end
  end

  return pandoc.Pandoc(out, doc.meta)
end
