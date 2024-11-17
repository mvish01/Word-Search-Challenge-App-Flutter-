import 'package:flutter/material.dart';
import 'package:word_search_app/grid_input_screen.dart';

class GridDisplayScreen extends StatefulWidget {
  final List<List<String>> grid;

  GridDisplayScreen({required this.grid});

  @override
  _GridDisplayScreenState createState() => _GridDisplayScreenState();
}

class _GridDisplayScreenState extends State<GridDisplayScreen> {
  final _searchController = TextEditingController();
  late List<List<String>> _highlightedGrid;
  late List<List<bool>> _highlight;

  @override
  void initState() {
    super.initState();
    _highlightedGrid = widget.grid;
    _highlight = List.generate(
      widget.grid.length,
          (i) => List.generate(widget.grid[0].length, (j) => false),
    );
  }

  void _searchInGrid(String text) {
    if (text.isEmpty) {
      setState(() {
        _highlightedGrid = widget.grid;
        _highlight = List.generate(
          widget.grid.length,
              (i) => List.generate(widget.grid[0].length, (j) => false),
        );
      });
      return;
    }

    List<List<bool>> newHighlight = List.generate(
      widget.grid.length,
          (i) => List.generate(widget.grid[0].length, (j) => false),
    );

    void highlight(int row, int col, int dr, int dc) {
      for (int i = 0; i < text.length; i++) {
        int r = row + i * dr;
        int c = col + i * dc;
        if (r < 0 || r >= widget.grid.length || c < 0 || c >= widget.grid[0].length) {
          return;
        }
        if (widget.grid[r][c] != text[i]) {
          return;
        }
        newHighlight[r][c] = true;
      }
    }

    for (int r = 0; r < widget.grid.length; r++) {
      for (int c = 0; c < widget.grid[0].length; c++) {
        highlight(r, c, 0, 1); // East
        highlight(r, c, 1, 0); // South
        highlight(r, c, 1, 1); // South-East
      }
    }

    setState(() {
      _highlight = newHighlight;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Grid Display')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(labelText: 'Search Text'),
              onChanged: _searchInGrid,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.grid[0].length,
                ),
                itemCount: widget.grid.length * widget.grid[0].length,
                itemBuilder: (context, index) {
                  int row = index ~/ widget.grid[0].length;
                  int col = index % widget.grid[0].length;
                  bool isHighlighted = _highlight[row][col];

                  return Container(
                    decoration: BoxDecoration(
                      color: isHighlighted ? Colors.yellow : Colors.transparent,
                      border: Border.all(),
                    ),
                    child: Center(
                      child: Text(
                        widget.grid[row][col],
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => GridInputScreen()),
                );
              },
              child: Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}