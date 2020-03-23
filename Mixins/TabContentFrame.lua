UiHelperTabContentMixin = {}

function UiHelperTabContentMixin:OnLoad()
  if self.title ~= nil then
    self.Title:SetText(self.title)
  end
end