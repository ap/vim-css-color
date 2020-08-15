export class ResultRow extends b.Component<IFood> {
  static id: string = "search-result-row";

  render(): b.INode {
    return (
      <Tr style={this.rowColorStyle(this.data.pH)}>
        <Td>{this.data.name}</Td>
        <Td>{this.data.pH}</Td>
      </Tr>
    );
  }

  private rowColorStyle(ph: number): b.IStyle {
    let backgroundColor = "#00000000";
    let color = "whitesmoke";
    if (ph >= 9) {
      backgroundColor = "#ac39ac";
    } else if (ph >= 8.5) {
      backgroundColor = "#d279d2";
    } else if (ph >= 8.25) {
      backgroundColor = "#e6b3e6";
    } else if (ph >= 8) {
      backgroundColor = "#80bfff";
    } else if (ph >= 7.75) {
      backgroundColor = "#77b300";
    } else if (ph >= 7.5) {
      backgroundColor = "#5cd65c";
    } else if (ph >= 7.25) {
      backgroundColor = "#00e600";
    } else if (ph >= 7) {
      backgroundColor = "#ffff33";
    } else if (ph >= 6.5) {
      backgroundColor = "#ffcc00";
    } else if (ph >= 6.25) {
      backgroundColor = "#ff8000";
    } else if (ph >= 6) {
      backgroundColor = "#ff6600";
    } else if (ph >= 5.5) {
      backgroundColor = "#ff1a1a";
    } else if (ph >= 5) {
      backgroundColor = "#cc0000";
      color = "#ffffff";
    } else if (ph >= 4.5) {
      backgroundColor = "#990000";
      color = "#ffffff";
    } else {
      backgroundColor = "#660000";
      color = "#ffffff";
    }

    return { backgroundColor, color };
  }
}
