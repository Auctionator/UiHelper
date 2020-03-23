UiHelperPanelGenerator = {}

local PANEL_TEMPLATES = {
  {
    name = "MaximizeMinimizeButtonFrameTemplate",
    needsHeight = false
  },
  {
    name = "TooltipBorderedFrameTemplate",
    needsHeight = true
  },
  {
    name = "ButtonFrameTemplateMinimizable",
    needsHeight = true
  },
  {
    name = "ButtonFrameTemplate",
    needsHeight = true
  },
  {
    name = "PortraitFrameTemplateMinimizable",
    needsHeight = true
  },
  {
    name = "PortraitFrameTemplate",
    needsHeight = true
  },
  {
    name = "PortraitFrameTemplateNoCloseButton",
    needsHeight = true
  },
  {
    name = "DefaultPanelTemplate",
    needsHeight = true
  },
  {
    name = "SimplePanelTemplate",
    needsHeight = true
  },
  {
    name = "DialogHeaderTemplate",
    needsHeight = true
  },
  -- Should create button to pop open a dialog template since they don't honor height for some reason
  -- {
  --   name = "DialogBorderOpaqueTemplate",
  --   needsHeight = true
  -- },
  -- {
  --   name = "DialogBorderTranslucentTemplate",
  --   needsHeight = true
  -- },
  -- {
  --   name = "DialogBorderDarkTemplate",
  --   needsHeight = true
  -- },
  -- {
  --   name = "DialogBorderTemplate",
  --   needsHeight = true
  -- },
  -- {
  --   name = "DialogBorderNoCenterTemplate",
  --   needsHeight = true
  -- },
  {
    name = "InsetFrameTemplate",
    needsHeight = true
  },
  {
    name = "NineSlicePanelTemplate",
    needsHeight = true,
    text = "\nNeeds a NineSlice theme (showing BFAMissionAlliance):\n" ..
      "SimplePanelTemplate, PortraitFrameTemplate, PortraitFrameTemplateMinimizable,\n" ..
      "ButtonFrameTemplateNoPortrait, ButtonFrameTemplateNoPortraitMinimizable, InsetFrameTemplate,\n" ..
      "BFAMissionHorde, BFAMissionAlliance, BFAMissionNeutral, Dialog",
    property = {
      name = "layoutType",
      value = "BFAMissionAlliance"
    }
  },
  {
    name = "ShadowOverlayTemplate",
    needsHeight = true
  }
}

function UiHelperPanelGenerator:OnLoad()
  UiHelperTabContentMixin.OnLoad(self)

  self.lastPanelAdded = nil
  self.height = 0

  table.sort(PANEL_TEMPLATES, function(a, b)
    return a.name < b.name
  end)

  for _, entry in ipairs(PANEL_TEMPLATES) do
    self:GeneratePanelFromTemplate(entry.name, entry)
  end
end

function UiHelperPanelGenerator:GeneratePanelFromTemplate(templateName, options)
  local frame = CreateFrame(
    "FRAME",
    "UiHelperFrame" .. templateName,
    self.ScrollFrame.PanelListingFrame,
    templateName
  )

  if options.needsHeight then
    frame:SetHeight(150)
  end

  if options.property ~= nil then
    frame[options.property.name] = options.property.value
    frame.OnLoad(frame)
  end

  local nameString = self.ScrollFrame.PanelListingFrame:CreateFontString(nil, "ARTWORK")
  nameString:SetFont("Fonts\\ARIALN.ttf", 14, "OUTLINE")
  nameString:SetText(templateName .. (options.text and options.text or "") .. (options.hasKeys and ("\n" .. options.hasKeys) or "" ))
  nameString:SetJustifyH("CENTER")

  nameString:SetPoint("RIGHT", self.ScrollFrame.PanelListingFrame, "RIGHT", -45, 0)

  if self.lastPanelAdded == nil then
    nameString:SetPoint("TOPLEFT", self.ScrollFrame.PanelListingFrame, "TOPLEFT", 0, 0)

    frame:SetPoint("CENTER", nameString, "CENTER")
    frame:SetPoint("TOPLEFT", nameString, "TOPLEFT", 0, 0)
  else
    nameString:SetPoint("TOPLEFT", self.lastPanelAdded, "BOTTOMLEFT", 0, 0)

    frame:SetPoint("CENTER", nameString, "CENTER")
    frame:SetPoint("TOPLEFT", nameString, "BOTTOMLEFT", 0, -5)
  end

  self.lastPanelAdded = frame

  self.height = self.height + frame:GetHeight() + 14 + 5
  self.ScrollFrame.PanelListingFrame:SetSize( 775, self.height )
end