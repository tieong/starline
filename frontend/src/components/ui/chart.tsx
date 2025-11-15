import * as React from "react"
import * as RechartsPrimitive from "recharts"

const COLORS = [
  "var(--primary-purple)",
  "var(--primary-blue)",
  "var(--primary-green)",
  "var(--primary-yellow)",
  "var(--primary-red)",
]

type ChartConfig = {
  [k in string]: {
    label?: React.ReactNode
    theme?: {
      light?: string
      dark?: string
    }
    icon?: React.ComponentType
  }
}

const ChartContext = React.createContext<ChartConfig | null>(null)

function useChart() {
  const context = React.useContext(ChartContext)

  if (!context) {
    throw new Error("useChart must be used within a <ChartContainer />")
  }

  return context
}

interface ChartContainerProps extends Omit<React.HTMLAttributes<HTMLDivElement>, 'children'> {
  config: ChartConfig
  children: React.ComponentType<any> | React.ReactNode
}

const ChartContainer = React.forwardRef<HTMLDivElement, ChartContainerProps>(
  ({ id, className = "", children, config, ...props }, ref) => {
    const uniqueId = React.useId()
    const chartId = `chart-${id || uniqueId.replace(/:/g, "")}`

    return (
      <ChartContext.Provider value={config}>
        <div
          data-chart={chartId}
          ref={ref}
          style={{ fontSize: "12px" }}
          className={className}
          {...props}
        >
          {children as React.ReactNode}
        </div>
      </ChartContext.Provider>
    )
  }
)
ChartContainer.displayName = "ChartContainer"

const ChartStyle = ({ id, config }: { id: string; config: ChartConfig }) => {
  const colorConfig = Object.entries(config).filter(
    ([_key, itemConfig]) => itemConfig.theme || typeof itemConfig.theme === "object"
  )

  if (colorConfig.length === 0) {
    return null
  }

  return (
    <style
      dangerouslySetInnerHTML={{
        __html: [
          `[data-chart=${id}] {`,
          ...colorConfig.map(([key, itemConfig]) => {
            const light = itemConfig?.theme?.light || COLORS[0]
            return `--color-${key}: ${light};`
          }),
          `}`,
        ].join("\n"),
      }}
    />
  )
}
ChartStyle.displayName = "ChartStyle"

const ChartTooltip = RechartsPrimitive.Tooltip

interface ChartTooltipContentProps extends React.HTMLAttributes<HTMLDivElement> {
  active?: boolean
  payload?: any[]
  label?: React.ReactNode
  indicator?: "dot" | "line"
}

const ChartTooltipContent = React.forwardRef<HTMLDivElement, ChartTooltipContentProps>(
  ({ active, payload, label, className = "", indicator = "dot", ...props }, ref) => {
    const { config } = useChart()

    if (!active || !payload || payload.length === 0) {
      return null
    }

    // Filter out Recharts-specific props that shouldn't be passed to DOM elements
    const {
      allowEscapeViewBox,
      animationDuration,
      animationEasing,
      axisId,
      contentStyle,
      filterNull,
      isAnimationActive,
      itemSorter,
      itemStyle,
      labelStyle,
      reverseDirection,
      useTranslate3d,
      wrapperStyle,
      activeIndex,
      accessibilityLayer,
      ...domProps
    } = props as any;

    return (
      <div
        ref={ref}
        style={{
          background: "var(--surface-card)",
          border: "2px solid var(--border-main)",
          padding: "var(--space-md)",
          borderRadius: "0",
          boxShadow: "var(--shadow-card)",
          minWidth: "180px",
        }}
        className={className}
        {...domProps}
      >
        {label && (
          <div style={{ 
            fontFamily: "var(--font-sans)",
            fontSize: "11px", 
            color: "var(--text-muted)", 
            marginBottom: "var(--space-md)",
            textTransform: "uppercase",
            letterSpacing: "0.08em",
            paddingBottom: "var(--space-sm)",
            borderBottom: "1px solid var(--border-subtle)",
          }}>
            {label}
          </div>
        )}
        <div style={{ display: "flex", flexDirection: "column", gap: "var(--space-md)" }}>
          {payload.map((item: any, index: number) => {
            const key = `${item.dataKey}`
            const itemConfig = config?.[key as keyof typeof config] as any
            const indicatorColor = item.payload.fill || item.color || `var(--color-${key})`

            return (
              <div
                key={`${item.dataKey}-${index}`}
                style={{
                  display: "flex",
                  alignItems: "center",
                  gap: "var(--space-md)",
                  fontSize: "13px",
                }}
              >
                <div
                  style={{
                    width: indicator === "dot" ? 8 : 3,
                    height: indicator === "dot" ? 8 : 32,
                    background: indicatorColor,
                    borderRadius: "0",
                    flexShrink: 0,
                  }}
                />
                <div style={{ 
                  flex: 1, 
                  display: "flex", 
                  flexDirection: "column",
                  gap: "2px",
                }}>
                  <div style={{ 
                    fontFamily: "var(--font-sans)",
                    fontSize: "11px",
                    color: "var(--text-muted)",
                    textTransform: "uppercase",
                    letterSpacing: "0.05em",
                  }}>
                    {itemConfig?.label || key}
                  </div>
                  <div style={{ 
                    fontFamily: "var(--font-serif)",
                    fontSize: "18px",
                    color: "var(--text-strong)", 
                    fontWeight: 600,
                    lineHeight: "1",
                  }}>
                    {typeof item.value === 'number' ? item.value.toFixed(1) : item.value}
                  </div>
                </div>
              </div>
            )
          })}
        </div>
      </div>
    )
  }
)
ChartTooltipContent.displayName = "ChartTooltipContent"

const ChartLegend = RechartsPrimitive.Legend

interface ChartLegendContentProps extends React.HTMLAttributes<HTMLDivElement> {
  payload?: any[]
  verticalAlign?: "top" | "middle" | "bottom"
}

const ChartLegendContent = React.forwardRef<HTMLDivElement, ChartLegendContentProps>(
  ({ className = "", ...props }, ref) => {
    const { config } = useChart()

    if (!props.payload || props.payload.length === 0) {
      return null
    }

    return (
      <div
        ref={ref}
        style={{
          display: "flex",
          flexWrap: "wrap",
          justifyContent: "center",
          gap: "var(--space-lg)",
          marginTop: "var(--space-lg)",
          paddingTop: "var(--space-lg)",
          borderTop: "1px solid var(--border-subtle)",
        }}
        className={className}
        {...(props as React.HTMLAttributes<HTMLDivElement>)}
      >
        {(props.payload || []).map((entry: any) => (
          <div
            key={`legend-${entry.value}`}
            style={{
              display: "flex",
              alignItems: "center",
              gap: "var(--space-md)",
              padding: "var(--space-sm) var(--space-md)",
              background: "var(--surface-subtle)",
              border: "1px solid var(--border-subtle)",
            }}
          >
            {entry.color && (
              <div
                style={{
                  width: 3,
                  height: 24,
                  background: entry.color,
                  borderRadius: "0",
                  flexShrink: 0,
                }}
              />
            )}
            <span style={{ 
              fontFamily: "var(--font-sans)",
              fontSize: "12px",
              fontWeight: 600,
              color: "var(--text-strong)",
              letterSpacing: "-0.01em",
            }}>
              {(config?.[entry.value as keyof typeof config] as any)?.label || entry.value}
            </span>
          </div>
        ))}
      </div>
    )
  }
)
ChartLegendContent.displayName = "ChartLegendContent"

export {
  ChartContainer,
  ChartStyle,
  ChartTooltip,
  ChartTooltipContent,
  ChartLegend,
  ChartLegendContent,
  useChart,
}
