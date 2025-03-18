import { Group } from "@visx/group";
import { scaleLinear } from "@visx/scale";
import { Point } from "@visx/point";
import { Line, LineRadial } from "@visx/shape";
import { useTheme } from "@mui/material/styles";

const degrees = 360;

const genAngles = (length: number) =>
  [...new Array(length + 1)].map((_, i) => ({
    angle:
      i * (degrees / length) + (length % 2 === 0 ? 0 : degrees / length / 2),
  }));

const genPoints = (length: number, radius: number) => {
  const step = (Math.PI * 2) / length;
  return [...new Array(length)].map((_, i) => ({
    x: radius * Math.sin(i * step),
    y: radius * Math.cos(i * step),
  }));
};

function genPolygonPoints(dataArray: number[], scale: (n: number) => number) {
  const step = (Math.PI * 2) / dataArray.length;
  const points: { x: number; y: number }[] = new Array(dataArray.length).fill({
    x: 0,
    y: 0,
  });
  const pointString: string = new Array(dataArray.length + 1)
    .fill("")
    .reduce((res, _, i) => {
      if (i > dataArray.length) return res;
      const xVal = scale(dataArray[i - 1]) * Math.sin(i * step);
      const yVal = scale(dataArray[i - 1]) * Math.cos(i * step);
      points[i - 1] = { x: xVal, y: yVal };
      res += `${xVal},${yVal} `;
      return res;
    });

  return { points, pointString };
}

type Props = {
  data: number[];
};
export default ({ data }: Props) => {
  const theme = useTheme();

  const width = 50;
  const height = 50;
  const defaultMargin = { top: 3, left: 3, right: 3, bottom: 3 };
  const margin = defaultMargin;

  const levels = 5;

  const xMax = width - margin.left - margin.right;
  const yMax = height - margin.top - margin.bottom;
  const radius = Math.min(xMax, yMax) / 2;

  const radialScale = scaleLinear<number>({
    range: [0, Math.PI * 2],
    domain: [360, 0],
  });

  const yScale = scaleLinear<number>({
    range: [0, radius],
    domain: [0, 1],
  });

  const webs = genAngles(data.length);
  const points = genPoints(data.length, radius);
  const polygonPoints = genPolygonPoints(data, (d) => yScale(d) ?? 0);
  const zeroPoint = new Point({ x: 0, y: 0 });

  return (
    <svg width={width} height={height} style={{ marginLeft: "1.5ch" }}>
      <Group top={height / 2 - margin.top} left={width / 2}>
        {[...new Array(levels)].map((_, i) => (
          <LineRadial
            key={`web-${i}`}
            data={webs}
            angle={(d) => radialScale(d.angle) ?? 0}
            radius={((i + 1) * radius) / levels}
            fill="none"
            stroke={theme.palette.text.disabled}
            strokeWidth={0.5}
            strokeOpacity={0.8}
            strokeLinecap="round"
          />
        ))}
        {[...new Array(data.length)].map((_, i) => (
          <Line
            key={`radar-line-${i}`}
            from={zeroPoint}
            strokeWidth={0.5}
            to={points[i]}
            stroke={theme.palette.text.disabled}
          />
        ))}
        <polygon
          points={polygonPoints.pointString}
          fill={theme.palette.primary.main}
          fillOpacity={0.3}
          stroke={theme.palette.primary.main}
          strokeWidth={0.5}
        />
        {polygonPoints.points.map((point, i) => (
          <circle
            key={`radar-point-${i}`}
            cx={point.x}
            cy={point.y}
            r={2}
            fill={theme.palette.primary.main}
          />
        ))}
      </Group>
    </svg>
  );
};
