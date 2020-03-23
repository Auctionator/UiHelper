UiHelperTextureGenerator = {}

local TEXTURE_TEMPLATES = {
  "UIPanelButtonHighlightTexture",
  "UI-PaperOverlay-AbilityTextBG",
  "UI-PaperOverlay-Bullet",
  "UI-PaperOverlay-Check",
  "UI-PaperOverlay-PaperHeader-SelectUp-Mid",
  "UI-PaperOverlay-AbilityTextBottomBorder",
  "UI-PaperOverlay-PaperHeader-SelectUp-Left",
  "UI-PaperOverlay-PaperHeader-SelectUp-Right",
  "_SearchBarLg",
  "!UI-Frame-RightTile",
  "!UI-Frame-LeftTile",
  "!UI-Frame-InnerRightTile",
  "!UI-Frame-InnerLeftTile",
  "_UI-Frame-BtnBotTile",
  "_UI-Frame-Bot",
  "_UI-Frame-InnerTopTile",
  "_UI-Frame-InnerBotTile",
  "_UI-Frame-TitleTileBg",
  "_UI-Frame-TitleTile",
  "_UI-Frame-TopTileStreaks",
  "UI-Frame-Portrait",
  "UI-Frame-TopCornerRight",
  "UI-Frame-BtnDivRight",
  "UI-Frame-InnerTopRight",
  "UI-Frame-TopLeftCorner",
  "UI-Frame-InnerTopLeft",
  "UI-Frame-InnerBotLeftCorner",
  "UI-Frame-InnerBotRight",
  "UI-Frame-BotCornerLeft",
  "UI-Frame-TopCornerLeft",
  "UI-Frame-BtnDivMiddle",
  "UI-Frame-BotCornerRight",
  "UI-Frame-TopCornerRightSimple",
  "UI-Frame-BtnDivLeft",
  "UI-Frame-InnerSplitLeft",
  "UI-Frame-InnerSplitRight",
  "GreenCheckMarkTemplate",
  "UIPanelButtonUpTexture",
  "UIPanelButtonDownTexture",
  "UIPanelButtonDisabledTexture",
  "UIPanelButtonDisabledDownTexture",
}

function UiHelperTextureGenerator:OnLoad()
  UiHelperTabContentMixin.OnLoad(self)

  self.lastTextureAdded = nil
  self.height = 0

  for _, textureName in ipairs(TEXTURE_TEMPLATES) do
    self:GenerateTextureSwatchFromTemplate(textureName)
  end
end

function UiHelperTextureGenerator:GenerateTextureSwatchFromTemplate(templateName)
  local frame = CreateFrame("Frame", nil, self.ScrollFrame.TextureListingFrame)
  frame:SetSize( 50, 50 )

  frame.texture = frame:CreateTexture(
    nil,
    "ARTWORK",
    templateName
  )
  frame.texture:SetAllPoints(frame)

  local nameString = frame:CreateFontString(nil, "ARTWORK")
  nameString:SetFont("Fonts\\ARIALN.ttf", 14, "OUTLINE")
  nameString:SetText(templateName)
  nameString:SetJustifyH("RIGHT")
  nameString:SetWidth(300)

  if self.lastTextureAdded == nil then
    frame:SetPoint("TOPLEFT", self.ScrollFrame.TextureListingFrame, "TOPLEFT", 0, 0)
  else
    frame:SetPoint("TOPLEFT", self.lastTextureAdded, "BOTTOMLEFT", 0, -5)
  end

  nameString:SetPoint("LEFT", frame, "RIGHT")

  self.lastTextureAdded = frame

  self.height = self.height + frame:GetHeight() + 5
  self.ScrollFrame.TextureListingFrame:SetSize(775, self.height)
end