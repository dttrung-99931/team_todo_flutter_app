import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:team_todo_app/constants/routes.dart';
import 'package:team_todo_app/constants/sizes.dart';
import 'package:team_todo_app/constants/styles.dart';
import '../../../../base/base_get_widget.dart';
import '../../../teams/components/list.dart';

import 'controller.dart';

class TeamSearchScreen extends BaseGetWidget<TeamSearchController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => Visibility(
            visible: !controller.isLoading,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.s4,
                vertical: Sizes.s4,
              ),
              child: controller.areSuggestedTeamsShown
                  ? Text('Teams suggested', style: Styles.subtitle)
                  : Text('Search results', style: Styles.subtitle),
            ),
          ),
        ),
        buildFutureWidget(
          Obx(
            () => TeamList(
              noDataTitle: controller.areSuggestedTeamsShown
                  ? 'No suggestions'
                  : controller.isSearchTextSubmitted
                      ? 'Not found'
                      : '',
              teams: controller.areSuggestedTeamsShown
                  ? controller.suggestedTeams
                  : controller.searchTeams,
              onTeamSelected: (team) async {
                toNamedRelative(RouteNames.TEAM_PREVIEW, arguments: team);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildAppBar() {
    return AppBar(
      leadingWidth: Sizes.s24,
      title: buildSearchBar(),
    );
  }

  Material buildSearchBar() {
    return Material(
      borderRadius: BorderRadius.circular(24),
      color: Colors.grey[200],
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () {},
        child: TextFormField(
          autofocus: true,
          onFieldSubmitted: controller.onSearchTextSubmitted,
          onChanged: controller.onSearchTextChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide.none,
              gapPadding: 0,
            ),
            contentPadding: EdgeInsets.only(
              right: 8,
              bottom: 8,
              top: 8,
            ),
            isDense: true,
            prefixIcon: Container(
              alignment: Alignment.center,
              child: Icon(
                Icons.search,
                color: Colors.black54,
                size: 24,
              ),
            ),
            prefixIconConstraints: BoxConstraints(
              maxWidth: 36,
              maxHeight: 24,
            ),
            hintText: 'Search teams',
          ),
        ),
      ),
    );
  }
}
