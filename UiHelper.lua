UiHelperFrameMixin = {}

function UiHelperFrameMixin:OnLoad()
  self:RegisterForDrag("LeftButton")

  -- Select first tab by default
  PanelTemplates_SetTab(UiHelperFrame, self.Tabs[1])
  PanelTemplates_SelectTab(self.Tabs[1])
  self.Tabs[1].TabFrame:Show()
end

function UiHelperFrameMixin:OnDragStart()
  self:StartMoving()
end

function UiHelperFrameMixin:OnDragStop()
  self:StopMovingOrSizing()
end

function UiHelperFrameMixin:RegisterTab(tab)
  if self.Tabs == nil then
    self.Tabs = {}
  end

  table.insert(self.Tabs, tab)
end

function UiHelperFrameMixin:UpdateTabContentFrames(selectedIndex)
  for index, tab in ipairs(self.Tabs) do
    if index ~= selectedIndex then
      tab:DeselectTab()
    end
  end
end
