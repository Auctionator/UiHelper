UiHelperTabButtonMixin = {}

local tabCount = 0

function UiHelperTabButtonMixin:OnLoad()
  tabCount = tabCount + 1
  self.index = tabCount

  PanelTemplates_SetNumTabs(UiHelperFrame, tabCount)
  UiHelperFrame:RegisterTab(self)

  self.TabFrame:Hide()
end

function UiHelperTabButtonMixin:OnClick()
  self.TabFrame:Show()

  PanelTemplates_SetTab(UiHelperFrame, self)
  PanelTemplates_SelectTab(self)

  UiHelperFrame:UpdateTabContentFrames(self.index)
end

function UiHelperTabButtonMixin:DeselectTab()
  self.TabFrame:Hide()
end