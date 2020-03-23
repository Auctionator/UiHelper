UiHelperButtonGenerator = {}

local BUTTON_TEMPLATES = {
  {
    name = "UIPanelGoldButtonTemplate",
    shouldResize = true
  },
  {
    name = "UIPanelButtonTemplate",
    shouldResize = true
  },
  {
    name = "UIPanelDynamicResizeButtonTemplate",
    shouldResize = true
  },
  -- Can't get these to work...
  -- {
  --   name = "TruncatedButtonTemplate",
  -- },
  -- {
  --   name = "TruncatedTooltipScriptTemplate",
  -- },
  {
    name = "UIRadioButtonTemplate",
    overrideType = "CheckButton"
  },
  {
    name = "UICheckButtonTemplate",
    overrideType = "CheckButton"
  },
  {
    name = "UIPanelCloseButtonNoScripts",
  },
  {
    name = "UIPanelHideButtonNoScripts",
  },
  {
    name = "UIStaticPopupSpecialCloseButton",
    text = " (/reload to show again)"
  },
  {
    name = "ColumnDisplayButtonShortTemplate",
    shouldResize = true
  },
  {
    name = "ColumnDisplayButtonNoScriptsTemplate",
    shouldResize = true
  },
  {
    name = "ColumnDisplayButtonTemplate",
    shouldResize = true
  },
  {
    name = "SquareIconButtonTemplate",
  },
  {
    name = "RefreshButtonTemplate",
  },
}

local BUTTON_PADDING = 40

function UiHelperButtonGenerator:OnLoad()
  UiHelperTabContentMixin.OnLoad(self)

  self.lastButtonAdded = nil
  self.height = 0

  table.sort(BUTTON_TEMPLATES, function(a, b)
    return a.name < b.name
  end)

  for _, entry in ipairs(BUTTON_TEMPLATES) do
    self:GenerateButtonFromTemplate(entry.name, entry)
  end
end

function UiHelperButtonGenerator:GenerateButtonFromTemplate(templateName, options)
  local button = CreateFrame(
    options.overrideType or "Button",
    "UiHelperButton" .. templateName,
    self.ScrollFrame.ButtonListingFrame,
    templateName
  )

  local nameString = self.ScrollFrame.ButtonListingFrame:CreateFontString(nil, "ARTWORK")
  nameString:SetFont("Fonts\\ARIALN.ttf", 14, "OUTLINE")
  nameString:SetText(templateName .. (options.text and options.text or ""))
  nameString:SetJustifyH("RIGHT")

  if button.text ~= nil then
    -- Check and Radio have a text FontString
    button.text:SetText(templateName)
  else
    button:SetText(templateName)
  end

  if options.shouldResize then
    -- some buttons should do this, but since they're not added via XML, they don't
    local width = button:GetWidth()
    local textWidth = button:GetTextWidth() + BUTTON_PADDING
    button:SetWidth(math.max(width, textWidth))
  end

  if options.overrideType == "CheckButton" then
    button:SetChecked(true)
  end

  if self.lastButtonAdded == nil then
    button:SetPoint("TOPLEFT", self.ScrollFrame.ButtonListingFrame, "TOPLEFT", 0, 0)
  else
    button:SetPoint("TOPLEFT", self.lastButtonAdded, "BOTTOMLEFT", 0, -5)
  end

  nameString:SetPoint("RIGHT", self.ScrollFrame.ButtonListingFrame, "RIGHT", -45, 0)
  nameString:SetPoint("LEFT", button, "RIGHT")

  self.lastButtonAdded = button

  self.height = self.height + button:GetHeight()
  self.ScrollFrame.ButtonListingFrame:SetSize( 775, self.height )
end