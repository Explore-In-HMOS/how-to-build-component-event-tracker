export function toNum(value: Length | undefined): number {
  return typeof value === 'number' ? Math.round(value) : 0;
}

export function clockTime(timestamp: number): string {
  const d: Date = new Date(timestamp);
  const h: string = d.getHours().toString().padStart(2, '0');
  const m: string = d.getMinutes().toString().padStart(2, '0');
  const s: string = d.getSeconds().toString().padStart(2, '0');
  return `${h}:${m}:${s}`;
}
