local FORMAT_NAME = FORMAT:match("^[^+]+")

local function has_class(el, class_name)
  return el.classes and el.classes:includes(class_name)
end

local function to_typst(blocks)
  local rendered = pandoc.write(pandoc.Pandoc(blocks), "typst")
  return (rendered:gsub("%s+$", ""))
end

local function build_typst_pair(accent_color, arabic_blocks, english_blocks)
  local lines = {
    "#align(center)[",
    "#block(width: 82%, inset: (y: 6pt, x: 0pt))["
  }

  if #arabic_blocks > 0 then
    table.insert(lines, "  #align(center)[")
    table.insert(lines, "    #set par(first-line-indent: 0pt, justify: false)")
    table.insert(lines, "    #set text(font: \"Amiri\", dir: rtl, lang: \"ar\", size: 14.3pt, fill: rgb(\"" .. accent_color .. "\"))")
    table.insert(lines, to_typst(arabic_blocks))
    table.insert(lines, "  ]")
  end

  if #english_blocks > 0 then
    if #arabic_blocks > 0 then
      table.insert(lines, "  #v(0.35em)")
    end
    table.insert(lines, "  #align(center)[")
    table.insert(lines, "    #set par(first-line-indent: 0pt, justify: false)")
    table.insert(lines, "    #set text(font: \"Noto Serif\", size: 11.1pt, fill: rgb(\"#33291f\"))")
    table.insert(lines, to_typst(english_blocks))
    table.insert(lines, "  ]")
  end

  table.insert(lines, "]")
  table.insert(lines, "]")
  return pandoc.RawBlock("typst", table.concat(lines, "\n"))
end

local function build_typst_arabic(blocks)
  local lines = {
    "#align(center)[",
    "  #set par(first-line-indent: 0pt, justify: false)",
    "  #set text(font: \"Amiri\", dir: rtl, lang: \"ar\", size: 16pt)",
    to_typst(blocks),
    "]"
  }
  return pandoc.RawBlock("typst", table.concat(lines, "\n"))
end

function Div(el)
  if has_class(el, "arabic") then
    if FORMAT_NAME == "typst" then
      return build_typst_arabic(el.content)
    end
  end

  if has_class(el, "quran") then
    local arabic_blocks = {}
    local english_blocks = {}

    for _, block in ipairs(el.content) do
      if block.t == "Div" and has_class(block, "quran-arabic") then
        arabic_blocks = block.content
      elseif block.t == "Div" and has_class(block, "quran-english") then
        english_blocks = block.content
      end
    end

    if FORMAT_NAME == "typst" then
      return build_typst_pair("5e4318", arabic_blocks, english_blocks)
    end
  end

  if has_class(el, "hadith") then
    local arabic_blocks = {}
    local english_blocks = {}

    for _, block in ipairs(el.content) do
      if block.t == "Div" and has_class(block, "hadith-arabic") then
        arabic_blocks = block.content
      elseif block.t == "Div" and has_class(block, "hadith-english") then
        english_blocks = block.content
      end
    end

    if FORMAT_NAME == "typst" then
      return build_typst_pair("4f4130", arabic_blocks, english_blocks)
    end
  end
end
