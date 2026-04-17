local FORMAT_NAME = FORMAT:match("^[^+]+")

local function has_class(el, class_name)
  return el.classes and el.classes:includes(class_name)
end

local function build_typst_toc()
  return pandoc.RawBlock("typst", "= Table of Contents\n#outline(depth: 2)")
end

function Div(el)
  if has_class(el, "page-break") then
    if FORMAT_NAME == "typst" then
      return {}
    end
  end

  if has_class(el, "frontpage") then
    if FORMAT_NAME == "typst" then
      return {}
    end
  end

  if has_class(el, "translators-introduction") then
    if FORMAT_NAME == "typst" then
      return {}
    end
  end
end

function Pandoc(doc)
  local toc_index = nil

  for i, block in ipairs(doc.blocks) do
    if block.t == "Div" and has_class(block, "toc-page") then
      toc_index = i
      break
    end
  end

  if not toc_index then
    return doc
  end

  local headers = {}
  for i = toc_index + 1, #doc.blocks do
    local block = doc.blocks[i]
    if block.t == "Header" and block.level <= 2 and block.identifier ~= "" then
      table.insert(headers, {
        level = block.level,
        identifier = block.identifier,
        title = block.content
      })
    end
  end

  if FORMAT_NAME == "typst" then
    doc.blocks[toc_index] = build_typst_toc()
  end

  return doc
end
