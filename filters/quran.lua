function Div(el)
  if el.classes:includes("quran") then
    return pandoc.Div(
      el.content,
      { class = "quran-block" }
    )
  end
end