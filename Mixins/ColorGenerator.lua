UiHelperColorGenerator = {}

function UiHelperColorGenerator:OnLoad()
  UiHelperTabContentMixin.OnLoad(self)

  self.lastStringAdded = nil
  self.height = 0

  local colors = {}

  for key, possibleColorObject in pairs(_G) do
    if key:find("COLOR") and type(possibleColorObject) == "table" then
      table.insert(colors, { name = key, color = possibleColorObject})
    end
  end

  table.sort(colors, function(a, b)
    return a.name < b.name
  end)

  for _, entry in ipairs(colors) do
    self:GenerateSampleColorString(entry.name, entry.color)
  end
end

function UiHelperColorGenerator:GenerateSampleColorString(colorName, colorObject)
  local colorString = self.ScrollFrame.ColorListingFrame:CreateFontString(nil, "ARTWORK")

  colorString:SetFont("Fonts\\ARIALN.ttf", 14, "OUTLINE")
  colorString:SetText(colorName)
  colorString:SetTextColor(colorObject.r, colorObject.g, colorObject.b, (colorObject.a and colorObject.a or 1))
  colorString:SetJustifyH("LEFT")

  -- Set location relative to last added string
  if self.lastStringAdded == nil then
    colorString:SetPoint("TOPLEFT", self.ScrollFrame.ColorListingFrame, "TOPLEFT", 0, 0)
    colorString:SetPoint("TOPRIGHT", self.ScrollFrame.ColorListingFrame, "TOPRIGHT", 0, 0)
  else
    colorString:SetPoint("TOPLEFT", self.lastStringAdded, "BOTTOMLEFT", 0, -5)
    colorString:SetPoint("TOPRIGHT", self.lastStringAdded, "BOTTOMRIGHT", 0, -5)
  end

  self.lastStringAdded = colorString

  self.height = self.height + 19
  self.ScrollFrame.ColorListingFrame:SetSize(775, self.height)
end
