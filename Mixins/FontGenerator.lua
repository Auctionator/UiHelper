UiHelperFontGenerator = {}

function UiHelperFontGenerator:OnLoad()
  UiHelperTabContentMixin.OnLoad(self)

  self.lastStringAdded = nil
  self.height = 0

  local fonts = {}

  for key, possibleFontObject in pairs(_G) do
    if key:find("Font") then
      table.insert(fonts, { name = key, font = possibleFontObject})
    end
  end

  table.sort(fonts, function(a, b)
    return a.name < b.name
  end)

  for _, entry in ipairs(fonts) do
    self:GenerateSampleFontString(entry.name, entry.font)
  end
end

function UiHelperFontGenerator:GenerateSampleFontString(fontName, fontObject)
  local fontString = self.ScrollFrame.FontListingFrame:CreateFontString(nil, "ARTWORK")

  local isOk = pcall(fontString.SetFontObject, fontString, fontObject)
  if not isOk then
    return
  end

  fontString:SetText(fontName)
  fontString:SetJustifyH("LEFT")

  -- Set location relative to last added string
  if self.lastStringAdded == nil then
    fontString:SetPoint("TOPLEFT", self.ScrollFrame.FontListingFrame, "TOPLEFT", 0, 0)
    fontString:SetPoint("TOPRIGHT", self.ScrollFrame.FontListingFrame, "TOPRIGHT", 0, 0)
  else
    fontString:SetPoint("TOPLEFT", self.lastStringAdded, "BOTTOMLEFT", 0, -5)
    fontString:SetPoint("TOPRIGHT", self.lastStringAdded, "BOTTOMRIGHT", 0, -5)
  end

  self.lastStringAdded = fontString

  self.height = self.height + 19
  self.ScrollFrame.FontListingFrame:SetSize(775, self.height)
end
