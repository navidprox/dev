import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/ui/ui.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

import 'package:portfolio/utils/utils.dart';
import 'package:portfolio/config/content.dart';
import 'package:portfolio/domain/models.dart';
import 'package:portfolio/packages/word_cloud/word_cloud.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isWide = screenSize.width >= 580;

    return MultiProvider(
      providers: [
        Provider<_ChatOverlayState>(
          create: (context) => _ChatOverlayState(),
          dispose: (context, value) => value.dispose(),
        ),
        Provider.value(value: _ResponsiveState(isWide: isWide)),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              gradient: backgroundGradient,
            ),
            child: DelayWidget(
              duration: const Duration(milliseconds: 4000),
              child: isWide ? _Wide() : _Portrait(),
            ),
          ),
        ),
      ),
    );
  }
}

class _ResponsiveState {
  _ResponsiveState({required this.isWide});

  final bool isWide;
}

//

class _Wide extends StatefulWidget {
  // ignore: unused_element_parameter
  const _Wide({super.key});

  @override
  State<_Wide> createState() => _WideState();
}

class _WideState extends State<_Wide> with DisposableState {
  late final pageController = disposable(PageController());

  @override
  Widget build(BuildContext context) {
    const radius = 10.0;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 900, maxHeight: 720),
        child: Container(
          margin: const EdgeInsets.all(24),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade900,
            borderRadius: BorderRadius.circular(radius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 16,
                offset: const Offset(4, 8),
              ),
            ],
          ),
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: wideContainerBorderColor,
              width: 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: 280),
                color: containerLeftBackgroundColor,
                child: const _Intro(),
              ),
              Expanded(
                child: Container(
                  color: containerRightBackgroundColor,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      _TabBar(
                        onChangeTab: (index) {
                          pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeIn,
                          );
                        },
                      ),
                      Expanded(
                        child: PageView(
                          // scrollDirection: Axis.vertical,
                          controller: pageController,
                          physics: NeverScrollableScrollPhysics(),
                          children: HomeTab.values
                              .map<Widget>(
                                (e) => switch (e) {
                                  HomeTab.about => const _About(),
                                  HomeTab.skills => const _TechStack(),
                                  HomeTab.projects => const _Projects(),
                                },
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//

class _Portrait extends StatefulWidget {
  // ignore: unused_element_parameter
  const _Portrait({super.key});

  @override
  State<_Portrait> createState() => _PortraitState();
}

class _PortraitState extends State<_Portrait> with DisposableState {
  final scrollViewKey = GlobalKey();
  final Map<HomeTab, GlobalKey> sectionKeys = Map.fromEntries(HomeTab.values.map((e) => MapEntry(e, GlobalKey())));

  late final controller = disposable(ScrollController());

  @override
  Widget build(BuildContext context) {
    final contentFeed = context.watch<Content>();
    const radius = 10.0;

    return Stack(
      children: [
        Positioned.fill(
          child: Center(
            child: Scrollbar(
              controller: controller,
              thumbVisibility: true,
              child: SingleChildScrollView(
                key: scrollViewKey,
                controller: controller,
                child: Container(
                  margin: const EdgeInsets.all(16.0),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade900,
                    borderRadius: BorderRadius.circular(radius),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.25),
                        blurRadius: 16,
                        offset: const Offset(4, 8),
                      ),
                    ],
                  ),
                  foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
                    border: Border.all(
                      color: wideContainerBorderColor,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        color: containerLeftBackgroundColor,
                        child: _Intro(),
                      ),
                      Container(
                        color: containerRightBackgroundColor,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ...HomeTab.values.map<Widget>(
                              (e) => Column(
                                key: sectionKeys[e],
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 16),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(
                                      contentFeed.homeTabTitles[e] ?? '*',
                                      // e.name.replaceFirstMapped(RegExp(r'([a-zA-Z])'), (m) => m.group(1)!.toUpperCase()),
                                      style: Theme.of(context).textTheme.headlineLarge,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Container(
                                    width: double.infinity,
                                    height: 1,
                                    color: wideContainerBorderColor,
                                  ),
                                  switch (e) {
                                    HomeTab.about => const _About(),
                                    HomeTab.skills => const _TechStack(),
                                    HomeTab.projects => const _Projects(),
                                  },
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: containerLeftBackgroundColor,
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: Center(
                            child: _Footer(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        PositionedDirectional(
          top: 32.0,
          start: 32.0,
          child: PopupMenuButton(
            tooltip: 'Navigation',
            icon: Icon(
              Icons.sort,
              color: titleColor.withValues(alpha: 0.5),
            ),
            itemBuilder: (context) => HomeTab.values
                .map(
                  (t) => PopupMenuItem<HomeTab>(
                    value: t,
                    child: Text(
                      contentFeed.homeTabTitles[t] ?? '*',
                      style: (Theme.of(context).textTheme.titleMedium ?? TextStyle()),
                    ),
                  ),
                )
                .toList(),
            onSelected: (value) {
              final c = sectionKeys[value]?.currentContext;

              final sh = scrollViewKey.currentContext?.size?.height;
              final h = c?.size?.height;

              final double alignment;
              if ((h ?? 0) <= 0 || (sh ?? 0) <= 0) {
                alignment = 0.0;
              } else {
                alignment = -80.0 / (h! - sh!);
              }

              if (c != null) Scrollable.ensureVisible(c, alignment: alignment);
            },
          ),
        ),
      ],
    );
  }
}

//

class _Intro extends StatelessWidget {
  const _Intro();

  @override
  Widget build(BuildContext context) {
    final responsiveState = context.watch<_ResponsiveState>();
    final screenSize = MediaQuery.of(context).size;
    final contentFeed = context.watch<Content>();

    final name = Text(
      contentFeed.name,
      style: (Theme.of(context).textTheme.displayMedium ?? const TextStyle()).copyWith(
        fontWeight: FontWeight.w900,
        fontSize: 32,
        height: 1.2,
      ),
    );

    final title = Text(
      contentFeed.title,
      style: (Theme.of(context).textTheme.bodyMedium ?? const TextStyle()).copyWith(
        color: titleColor,
        // fontWeight: FontWeight.w900,
        fontSize: 22,
        // height: 1.2,
      ),
    );

    final socials = [
      for (SocialLink socialLink in contentFeed.socialLinks)
        LinkWrap(
          url: socialLink.url,
          builder: (context, onClick) => IconButton(
            tooltip: socialLink.tooltip,
            icon: FaIcon(socialLink.icon),
            onPressed: onClick == null ? null : (() => onClick()),
          ),
        ),
    ];

    final chat = ElevatedButton(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 16.0,
        children: [
          Text(
            contentFeed.chatButtonText,
            textScaler: TextScaler.linear(1.2),
          ),
          FaIcon(FontAwesomeIcons.message),
        ],
      ),
      onPressed: () => context.read<_ChatOverlayState>().show(context),
    );

    Widget wide() {
      if (screenSize.height < 420) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 6),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: socials,
            ),
            const SizedBox(width: 6),
            Container(
              width: 1,
              height: double.infinity,
              color: wideContainerBorderColor,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),
                    name,
                    const SizedBox(height: 16),
                    title,
                    const Spacer(),
                    chat,
                    const SizedBox(height: 16),
                    const _Footer(),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ],
        );
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 46),
            name,
            const SizedBox(height: 16),
            title,
            const SizedBox(height: 32),
            Wrap(
              children: socials,
            ),
            const Spacer(),
            chat,
            const SizedBox(height: 32),
            const _Footer(),
            const SizedBox(height: 8),
          ],
        ),
      );
    }

    Widget portrait() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 46),
            name,
            const SizedBox(height: 16),
            title,
            const SizedBox(height: 32),
            Wrap(
              children: socials,
            ),
            const SizedBox(height: 32),
            chat,
            const SizedBox(height: 32),
          ],
        ),
      );
    }

    return switch (responsiveState.isWide) {
      true => wide(),
      false => portrait(),
    };
  }
}

/// Footer for portrait
class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      children: [
        Tooltip(
          message: 'Copyright',
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 25, maxHeight: 25),
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: FittedBox(child: Icon(Icons.copyright, color: copyrightIconColor)),
              ),
              onTap: () => showLicensePage(context: context),
            ),
          ),
        ),
        LinkWrap(
          url: 'https://github.com/navidprox/dev',
          builder: (context, onClick) => Tooltip(
            message: 'Source',
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 25, maxHeight: 25),
              child: InkWell(
                onTap: onClick == null ? null : (() => onClick()),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: FittedBox(child: FaIcon(FontAwesomeIcons.code, color: copyrightIconColor)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//

/// TabBar for wide
class _TabBar extends StatefulWidget {
  const _TabBar({
    // ignore: unused_element_parameter
    super.key,
    required this.onChangeTab,
  });

  final Function(int index) onChangeTab;

  @override
  State<_TabBar> createState() => _TabBarState();
}

class _TabBarState extends State<_TabBar> with DisposableState, SingleTickerProviderStateMixin {
  late final TabController tabController = disposable(
    TabController(length: HomeTab.values.length, vsync: this)
      ..addListener(() => widget.onChangeTab(tabController.index)),
  );

  @override
  Widget build(BuildContext context) {
    final contentFeed = context.watch<Content>();

    return DefaultTabController(
      length: HomeTab.values.length,
      child: TabBar(
        controller: tabController,
        tabs: [
          for (String tab in contentFeed.homeTabTitles.values) Tab(text: tab),
        ],
      ),
    );
  }
}

//

class _About extends StatefulWidget {
  // ignore: unused_element_parameter
  const _About({super.key});

  @override
  State<_About> createState() => _AboutState();
}

class _AboutState extends State<_About> with DisposableState {
  late final controller = disposable(ScrollController());

  @override
  Widget build(BuildContext context) {
    final contentFeed = context.watch<Content>();
    final responsiveState = context.watch<_ResponsiveState>();

    final ret = Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(16.0),
      color: containerRightBackgroundColor.contrastWB().withValues(alpha: 0.05),
      child: CalculatedBuilder(
        key: ValueKey('${contentFeed.hashCode},${longTextStyle.hashCode}'),
        calculate: () => contentFeed.about(style: longTextStyle),
        builder: (context, value) => Text.rich(
          value,
          // textAlign: TextAlign.justify,
        ),
      ),
    );

    return switch (responsiveState.isWide) {
      true => Scrollbar(
        controller: controller,
        thumbVisibility: true,
        child: SingleChildScrollView(
          controller: controller,
          child: ret,
        ),
      ),
      false => ret,
    };
  }
}

class _TechStack extends StatefulWidget {
  // ignore: unused_element_parameter
  const _TechStack({super.key});

  @override
  State<_TechStack> createState() => _TechStackState();
}

class _TechStackState extends State<_TechStack> with DisposableState{
  late final controller = disposable(ScrollController());

  bool isCloud = false;

  @override
  Widget build(BuildContext context) {
    final screenSizeI = MediaQuery.of(context).size;
    final screenPaddingI = MediaQuery.of(context).padding;

    final usableScreenSize = Size(
      screenSizeI.width - screenPaddingI.horizontal,
      screenSizeI.height - screenPaddingI.vertical,
    );

    final responsiveState = context.watch<_ResponsiveState>();

    final wordsWidget = Selector<Content, List<Skill>>(
      key: ValueKey(isCloud),
      selector: (context, content) => content.skills,
      builder: (context, skills, child) {
        if (!isCloud) {
          final ret = Container(
            width: double.infinity,
            color: containerRightBackgroundColor.contrastWB().withValues(alpha: 0.05),
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            child: CalculatedBuilder<String>(
              key: ValueKey(skills),
              calculate: () {
                final List<MapEntry<int, List<String>>> groups = skills
                    // ignore: prefer_collection_literals
                    .fold(Map<int, List<Skill>>(), (map, skill) {
                      if (skill.group == null) return map;

                      final s = map[skill.group] ?? [];
                      s.add(skill);
                      map[skill.group!] = s;
                      return map;
                    })
                    .entries
                    .map((e) {
                      final v = e.value;
                      v.sort((a, b) => b.weight.compareTo(a.weight));
                      return MapEntry(e.key, v.map((s) => s.word).toList());
                    })
                    .toList();

                groups.sort((a, b) => a.key.compareTo(b.key));

                return groups.map((g) => '- ${g.value.join(", ")}').join('\n');
              },
              builder: (context, value) => Text(
                value,
                style: longTextStyle.copyWith(
                  // fontSize: minTextSize + ((skill.weight - minValue) / valueDiff) * (textSizeDiff),
                ),
              ),
            ),
          );

          return switch (responsiveState.isWide) {
            true => Scrollbar(
              controller: controller,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: controller,
                child: ret,
              ),
            ),
            false => ret,
          };
        }

        final ret = CalculatedBuilder<WordCloudData>(
          key: ValueKey(skills),
          calculate: () {
            final s = skills.map((e) => (word: e.word, weight: e.weight)).toList();
            s.sort((a, b) => b.weight.compareTo(a.weight));
            return WordCloudData(sortedData: s);
          },
          builder: (context, value) => Container(
            color: containerRightBackgroundColor.contrastWB().withValues(alpha: 0.05),
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            child: LayoutBuilder(
              builder: (context, constraints) => WordCloudView(
                key: ValueKey(constraints),
                maxtextsize: min(50, min(constraints.maxWidth, constraints.maxHeight) * 0.2),
                mintextsize: max(10, min(constraints.maxWidth, constraints.maxHeight) * 0.03),
                data: value,
                // shape: WordCloudCircle(radius: min(constraints.maxWidth, constraints.maxHeight)),
                mapcolor: Colors.transparent,
                mapwidth: constraints.maxWidth,
                mapheight: constraints.maxHeight,
                colorlist: wordCloudColors,
              ),
            ),
          ),
        );

        return switch (responsiveState.isWide) {
          true => ret,
          false => SizedBox(
            height: usableScreenSize.height,
            child: ret,
          ),
        };
      },
    );

    return switch (responsiveState.isWide) {
      true => Stack(
        children: [
          Positioned.fill(
            child: wordsWidget,
          ),
          PositionedDirectional(
            end: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Switch(
                value: isCloud,
                trackOutlineColor: WidgetStatePropertyAll(Colors.white),
                onChanged: (value) => setState(() => isCloud = value),
              ),
            ),
          ),
        ],
      ),
      false => () {
        isCloud = false;
        return wordsWidget;
      }(),
    };
  }
}

class _Projects extends StatefulWidget {
  // ignore: unused_element_parameter
  const _Projects({super.key});

  @override
  State<_Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<_Projects> with DisposableState{
  late final controller = disposable(ScrollController());

  @override
  Widget build(BuildContext context) {
    final responsiveState = context.watch<_ResponsiveState>();
    final projects = context.select<Content, List<Project>>((c) => c.projects);

    final ret = Container(
      color: containerRightBackgroundColor.contrastWB().withValues(alpha: 0.05),
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: projects
            .map<Widget>((p) => _ProjectItem(project: p))
            .joinWith((_, __) => const SizedBox(height: 16))
            .toList(),
      ),
    );

    return switch (responsiveState.isWide) {
      true => Scrollbar(
        controller: controller,
        thumbVisibility: true,
        child: SingleChildScrollView(
          controller: controller,
          child: ret,
        ),
      ),
      false => ret,
    };
  }
}

class _ProjectItem extends StatefulWidget {
  // ignore: unused_element_parameter
  const _ProjectItem({super.key, required this.project});

  final Project project;

  @override
  State<_ProjectItem> createState() => _ProjectItemState();
}

class _ProjectItemState extends State<_ProjectItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => isExpanded = !isExpanded),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: wideContainerBorderColor),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              spacing: 8.0,
              children: [
                Expanded(
                  child: Text(
                    widget.project.title,
                    style: (Theme.of(context).textTheme.titleLarge ?? const TextStyle()).copyWith(
                      color: containerRightBackgroundColor.contrastWB().withValues(alpha: 0.8),
                      height: 1.6,
                      fontSize: 19,
                    ),
                  ),
                ),
                FaIcon(
                  isExpanded ? FontAwesomeIcons.chevronUp : FontAwesomeIcons.chevronDown,
                  size: 17,
                  color: containerRightBackgroundColor.contrastWB().withValues(alpha: 0.8),
                ),
              ],
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeOut,
              child: ConstrainedBox(
                constraints: isExpanded ? BoxConstraints() : BoxConstraints(maxHeight: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    CalculatedBuilder(
                      key: ValueKey('${widget.project.description.hashCode},${longTextStyle.hashCode}'),
                      calculate: () => widget.project.description(
                        longTextStyle.copyWith(
                          fontSize: 19,
                        ),
                      ),
                      builder: (context, value) => Text.rich(
                        value,
                        // textAlign: TextAlign.justify,
                      ),
                    ),
                    if (widget.project.imageAssets.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Center(
                        child: ElevatedButton(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 16.0,
                            children: [
                              Text(
                                context.select<Content, String>((c) => c.projectGalleryButtonText),
                                textScaler: TextScaler.linear(1.2),
                              ),
                              FaIcon(FontAwesomeIcons.images),
                            ],
                          ),
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) => _ProjectGalleryDialog(project: widget.project),
                          ),
                        ),
                      ),
                    ],
                    if (widget.project.links.isNotEmpty)
                      for (ProjectLink link in widget.project.links) ...[
                        const SizedBox(height: 16),
                        Center(
                          child: ElevatedButton(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              spacing: 16.0,
                              children: [
                                Text(
                                  link.title,
                                  textScaler: TextScaler.linear(1.2),
                                ),
                                // FaIcon(FontAwesomeIcons.images),
                              ],
                            ),
                            onPressed: () => launchUrlString(link.url, mode: LaunchMode.externalApplication),
                          ),
                        ),
                      ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectGalleryDialog extends StatefulWidget {
  // ignore: unused_element_parameter
  const _ProjectGalleryDialog({super.key, required this.project});

  final Project project;

  @override
  State<_ProjectGalleryDialog> createState() => _ProjectGalleryDialogState();
}

class _ProjectGalleryDialogState extends State<_ProjectGalleryDialog> with DisposableState {
  late String showingImage = widget.project.imageAssets.first;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    const radius = 10.0;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: BorderSide(color: wideContainerBorderColor),
        ),
        // backgroundColor: containerLeftBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.project.title,
                        style: (Theme.of(context).textTheme.titleMedium ?? TextStyle()).copyWith(
                          color: Colors.white.withValues(alpha: 0.4),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(4.0, 0),
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.close,
                            size: 20,
                            color: Colors.white.withValues(alpha: 0.4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 8,
                          children: widget.project.imageAssets
                              .mapIndexed(
                                (index, e) => InkWell(
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    foregroundDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(radius / 2),
                                      border: Border.all(
                                        color: showingImage == e ? const Color(0xFF2189CF) : wideContainerBorderColor,
                                        width: 2,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      clipBehavior: Clip.antiAlias,
                                      borderRadius: BorderRadius.circular(radius / 2),
                                      child: Image.asset(
                                        e,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  onTap: () => setState(() => showingImage = e),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 150),
                          transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
                          child: Container(
                            key: ValueKey(showingImage),
                            foregroundDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radius / 2),
                              border: Border.all(
                                color: wideContainerBorderColor,
                              ),
                            ),
                            child: ClipRRect(
                              clipBehavior: Clip.antiAlias,
                              borderRadius: BorderRadius.circular(radius / 2),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: screenSize.width * 0.6),
                                child: InteractiveViewer(
                                  child: Image.asset(showingImage),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//

class _ChatOverlayState {
  OverlayEntry? overlayEntry;
  final GlobalKey<_ChatWidgetState> widgetKey = GlobalKey();

  Future show(BuildContext context) async {
    if (overlayEntry == null) {
      overlayEntry = OverlayEntry(
        maintainState: true,
        canSizeOverlay: true,
        builder: (context) => ChangeNotifierProvider<ChatViewModel>(
          create: (BuildContext context) => ChatViewModel(chatRepository: context.read()),
          builder: (context, child) => _ChatWidget(key: widgetKey),
        ),
      );

      Overlay.of(context).insert(overlayEntry!);
    } else {
      await waitFrame();
      widgetKey.currentState?.show();
    }
  }

  Future hide() async {
    await waitFrame();
    widgetKey.currentState?.hide();
  }

  void dispose() {
    overlayEntry?.remove();
    overlayEntry?.dispose();
    overlayEntry = null;
  }
}

class _ChatWidget extends StatefulWidget {
  const _ChatWidget({super.key});

  @override
  State<_ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<_ChatWidget> with DisposableState {
  late final textController = disposable(TextEditingController());
  late final textFocusNode = FocusNode(
    onKeyEvent: (FocusNode node, KeyEvent evt) {
      if (!(HardwareKeyboard.instance.isShiftPressed ||
              HardwareKeyboard.instance.isAltPressed ||
              HardwareKeyboard.instance.isControlPressed) &&
          evt.logicalKey == LogicalKeyboardKey.enter) {
        if (evt is KeyDownEvent) send(textController.text);

        return KeyEventResult.handled;
      } else {
        return KeyEventResult.ignored;
      }
    },
  );

  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static const loadCount = 20;

  bool showing = true;

  void show() {
    showing = true;
    if (mounted) setState(() {});
  }

  void hide() {
    showing = false;
    if (mounted) setState(() {});
  }

  void send(String text) async {
    final result = await context.read<ChatViewModel>().sendMessage.run(text);
    switch (result) {
      case Ok<Message>():
        textController.clear();
        break;
      case Error<Message>():
        if (mounted && showing) {
          scaffoldMessengerKey.currentState?.showSnackBar(
            SnackBar(content: Text('Something went wrong! (${result.error})')),
          );
        }
        break;
    }
  }

  @override
  void initState() {
    super.initState();

    waitFrame().then((_) {
      if (mounted) context.read<ChatViewModel>().loadMorePassMessages.run(loadCount);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final contentFeed = context.watch<Content>();

    final size = screenSize.shortestSide > 500
        ? Size(400, 400)
        : Size(min(400, screenSize.width * 0.8), min(400, screenSize.height * 0.8));
    const radius = 10.0;

    return Offstage(
      offstage: !showing,
      child: ScaffoldMessenger(
        key: scaffoldMessengerKey,
        child: Align(
          alignment: AlignmentDirectional.bottomEnd,
          child: SizedBox.fromSize(
            size: size,
            child: Scaffold(
              primary: false,
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              body: SafeArea(
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    color: containerLeftBackgroundColor,
                    borderRadius: BorderRadius.circular(radius),
                    border: Border.all(color: Colors.blue.shade800),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withValues(alpha: 0.15),
                        blurRadius: 25,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              contentFeed.chatTitle,
                              style: (Theme.of(context).textTheme.titleMedium ?? TextStyle()).copyWith(
                                color: Colors.white.withValues(alpha: 0.4),
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(4.0, 0),
                              child: InkWell(
                                onTap: hide,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(
                                    Icons.close,
                                    size: 20,
                                    color: Colors.white.withValues(alpha: 0.4),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: wideContainerBorderColor,
                      ),
                      Expanded(
                        child: _ChatMessages(
                          messages: context.select((ChatViewModel viewModel) => viewModel.messages).toList(),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: wideContainerBorderColor,
                      ),
                      // const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: TextField(
                                enabled: !context.select((ChatViewModel viewModel) => viewModel.sendMessage.isRunning),
                                controller: textController,
                                focusNode: textFocusNode,
                                onSubmitted: send,
                                minLines: 1,
                                maxLines: 5,
                                decoration: InputDecoration(hintText: contentFeed.chatFieldHint),
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: FaIcon(FontAwesomeIcons.paperPlane),
                              onPressed: context.select((ChatViewModel viewModel) => viewModel.sendMessage.isRunning)
                                  ? null
                                  : (() => send(textController.text)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ChatMessages extends StatefulWidget {
  // ignore: unused_element_parameter
  _ChatMessages({super.key, required List<Message> messages}) : messages = messages.reversed.toList();

  final List<Message> messages;

  @override
  State<_ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<_ChatMessages> with DisposableState {
  late final controller = disposable(ScrollController());

  @override
  Widget build(BuildContext context) {
    final contentFeed = context.watch<Content>();

    final content = switch (widget.messages.isEmpty) {
      true => Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.all(32.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                contentFeed.chatEmptyMessage,
                textAlign: TextAlign.center,
                style: (Theme.of(context).textTheme.bodyMedium ?? const TextStyle()).copyWith(height: 1.6),
              ),
              const SizedBox(height: 16.0),
              FaIcon(FontAwesomeIcons.comments),
            ],
          ),
        ),
      ),
      false => Scrollbar(
        controller: controller,
        thumbVisibility: true,
        child: ListView.builder(
          controller: controller,
          itemCount: widget.messages.length,
          reverse: true,
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
          itemBuilder: (BuildContext context, int index) {
            final message = widget.messages[index];

            return Align(
              alignment: switch (message.side) {
                MessageSide.server => AlignmentDirectional.centerStart,
                MessageSide.user => AlignmentDirectional.centerEnd,
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: switch (message.side) {
                    MessageSide.server => Colors.blue.withValues(alpha: 0.2),
                    MessageSide.user => Colors.white.withValues(alpha: 0.2),
                  },
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  message.text,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            );
          },
        ),
      ),
    };

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
      child: content,
    );
  }
}
