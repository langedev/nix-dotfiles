export const Clock = (monitor = 0) => {

    return Widget.Window({
        monitor,
        name: `switch${monitor}`,
        anchor: ['top', 'left', 'right'],
        margins: [864, 1030],
        css: 'background: transparent;',
        child: container,
    });
};

const container = Widget.Box({
    css: `
      min-height: 110px;
      min-width: 500px;
      border: 4px solid #f4d80a;
      border-radius: 50px;
      margin: 3px;
      box-shadow: 0 0 0 3px white;
    `,
});
