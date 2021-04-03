local AddonName, Addon = ...
local FlyPaper = LibStub('LibFlyPaper-2.0')

Minimap.stickyTolerance = 8

function Minimap:Stick()
    if self:StickToFrame() or --[[ self:StickToGrid() or ]] self:StickToEdge() then
        return true
    end

    return false
end

-- bar anchoring
function Minimap:StickToFrame()
    local point, relFrame, relPoint = FlyPaper.GetBestAnchor(self, self.stickyTolerance)

    if point then
        self:ClearAllPoints()
        self:SetPoint(point, relFrame, relPoint)

        return true
    end

    return false
end

--[[ grid anchoring
function Minimap:StickToGrid()
    if not Addon:GetAlignmentGridEnabled() then
        return false
    end

    local xScale, yScale = Addon:GetAlignmentGridScale()

    local point, relPoint, x, y = FlyPaper.GetBestAnchorForParentGrid(
        self,
        xScale,
        yScale,
        self.stickyTolerance
    )

    if point then
        self:ClearAllPoints()
        self:SetPoint(point, self:GetParent(), relPoint, x, y)

        self:SaveRelativePostiion()
        return true
    end

    return false
end
]]

-- screen edge and center point anchoring
function Minimap:StickToEdge()
    local point, relPoint, x, y = FlyPaper.GetBestAnchorForParent(self)
    local scale = self:GetScale()

    if point then
        local stick = false

        if math.abs(x * scale) <= self.stickyTolerance then
            x = 0
            stick = true
        end

        if math.abs(y * scale) <= self.stickyTolerance then
            y = 0
            stick = true
        end

        if stick then
            self:ClearAllPoints()
            self:SetPoint(point, self:GetParent(), relPoint, x, y)

            return true
        end
    end

    return false
end
