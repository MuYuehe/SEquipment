Scorpio "SEquipment.horizontalLayoutManager" ""
--======================--
namespace "SEquipment.Layout"
--======================--
import "Scorpio.UI.Layout"
--======================--
class "HorizontalLayoutManager"   (function(_ENV)

    extend "ILayoutManager"

    -----------------------------------------------------------
    --                 Implementation method                 --
    -----------------------------------------------------------
    --- Refresh the layout of the target frame
    function RefreshLayout(self, frame, iter, padding)

        local minResize         = Style[frame].minResize
        local minWidth          = minResize and minResize.width or 0
        local totalWidth        = 0
        local prev
        local spacing           = padding and padding.left or 0
        local showHide          = self.ShowHideChildren
        local height            = frame:GetHeight()
        local maxHeight         = 0

        local ChildrenWidth     = 0
        for i, child, margin in iter do
            local top = margin and margin.top or 0
            if top > 0 and top < 1 then
                top = height * top
            end
            local offsetx = spacing + (margin and margin.left or 0)
            local offsety = (padding and padding.top or 0) + top

            child:ClearAllPoints()

            if not prev then
                child:SetPoint("LEFT", offsetx, 0)
            else
                child:SetPoint("LEFT", prev,"RIGHT", offsetx, 0)
            end
            child:SetPoint("TOP", 0, -offsety)

            if margin and margin.bottom then
                local bottom = margin.bottom
                if bottom > 0 and bottom < 1 then
                    bottom = height * bottom
                end
                child:SetPoint("BOTTOM", 0, ((padding and padding.bottom or 0) + bottom))
            end

            if showHide and not child:IsShown() then
                showHide = showHide == true and {} or showHide
                showHide[#showHide + 1] = child
            end

            totalWidth = totalWidth + offsetx + child:GetWidth()
            prev = child
            spacing = margin and margin.right or 0
            maxHeight = math.max(maxHeight, child:GetHeight())
        end

        totalWidth = math.max(totalWidth + spacing + (padding and padding.right or 0), minWidth or 0 )
        if math.abs(frame:GetWidth() - totalWidth) > 10 then
            frame:SetWidth(math.max(totalWidth, minWidth or 0))
        end
        frame:SetHeight(maxHeight + (padding and padding.top or 0))
        if type(showHide) == "table" then
            for i = 1, #showHide do
                showHide[i]:SetShown(true)
            end
        end
    end

    -----------------------------------------------------------
    --                       property                        --
    -----------------------------------------------------------
    --- Whether show the hidden children when re-layouted
    property "ShowHideChildren" { type = Boolean, default = false }

    -----------------------------------------------------------
    --                      constructor                      --
    -----------------------------------------------------------
    __Arguments__{ Boolean/nil, Boolean/nil }
    function __ctor(self, includeHideChildren, showHideChildren)
        self.IncludeHideChildren= includeHideChildren
        self.ShowHideChildren   = showHideChildren
    end
end)

class "VerticalLayoutManager"   (function(_ENV)
    extend "ILayoutManager"

    -----------------------------------------------------------
    --                 Implementation method                 --
    -----------------------------------------------------------
    --- Refresh the layout of the target frame
    function RefreshLayout(self, frame, iter, padding)
        local minResize         = Style[frame].minResize
        local minHeight         = minResize and minResize.height or 0
        local totalHeight       = 0
        local prev
        local spacing           = padding and padding.top  or 0
        local showHide          = self.ShowHideChildren
        local width             = frame:GetWidth()
        local maxWidth          = 0

        for i, child, margin in iter do
            local left          = margin and margin.left or 0
            if left > 0 and left < 1 then -- as percent
                left            = width * left
            end

            local offsetx       = (padding and padding.left or 0) + left
            local offsety       = spacing + (margin and margin.top  or 0)

            child:ClearAllPoints()

            if not prev then
                child:SetPoint("TOP", 0, - offsety)
            else
                child:SetPoint("TOP", prev, "BOTTOM", 0, - offsety)
            end

            child:SetPoint("LEFT", offsetx, 0)

            if margin and margin.right then
                local right     = margin.right
                if right > 0 and right < 1 then
                    right       = width * right
                end
                child:SetPoint("RIGHT", - ((padding and padding.right or 0) + right), 0)
            end
            if showHide and not child:IsShown() then
                showHide        = showHide == true and {} or showHide
                showHide[#showHide + 1] = child
            end

            totalHeight         = totalHeight + offsety + child:GetHeight()
            prev                = child
            spacing             = margin and margin.bottom or 0
            if child:IsShown() then
                maxWidth            = math.max(maxWidth, child:GetWidth())
            end
        end

        totalHeight             = math.max(totalHeight + spacing + (padding and padding.bottom or 0), minHeight or 0)
        if math.abs(frame:GetHeight() - totalHeight) > 10 then
            frame:SetHeight(math.max(totalHeight, minHeight or 0))
        end
        frame:SetWidth(maxWidth + (padding and padding.left or 0) + (padding and padding.right or 0))
        if type(showHide) == "table" then
            for i = 1, #showHide do
                showHide[i]:SetShown(true)
            end
        end
    end

    -----------------------------------------------------------
    --                       property                        --
    -----------------------------------------------------------
    --- Whether show the hidden children when re-layouted
    property "ShowHideChildren" { type = Boolean, default = false }

    -----------------------------------------------------------
    --                      constructor                      --
    -----------------------------------------------------------
    __Arguments__{ Boolean/nil, Boolean/nil }
    function __ctor(self, includeHideChildren, showHideChildren)
        self.IncludeHideChildren= includeHideChildren
        self.ShowHideChildren   = showHideChildren
    end
end)