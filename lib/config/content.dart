import 'dart:math';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/ui/ui.dart';
import 'package:portfolio/utils/utils.dart';

typedef SocialLink = ({IconData icon, String tooltip, String url});

typedef Skill = ({String word, double weight, int? group});

typedef Project = ({
  String title,
  InlineSpan Function(TextStyle style) description,
  Set<String> imageAssets,
  List<ProjectLink> links,
});

typedef ProjectLink = ({String title, String url});

enum HomeTab { about, skills, projects }

/// It's directly accessible now to allow being dynamic, may later divide languages
class Content {
  // Content._();
  //
  // static Content instance = Content._();
  //
  // factory Content() => instance;

  //

  final String name = "Hi,\nI'm Navid";

  final String title = 'Flutter developer';

  late final List<SocialLink> socialLinks = [
    (
      icon: FontAwesomeIcons.linkedin,
      tooltip: 'linkedin'.toUpperCase(),
      url: 'https://www.linkedin.com/in/navid96',
    ),
    (
      icon: FontAwesomeIcons.stackOverflow,
      tooltip: 'stackOverflow'.toUpperCase(),
      url: 'https://stackoverflow.com/users/6094503/navid',
    ),
    (icon: FontAwesomeIcons.github, tooltip: 'github'.toUpperCase(), url: 'https://github.com/navidprox'),
    (icon: FontAwesomeIcons.envelope, tooltip: 'mail'.toUpperCase(), url: 'mailto:navidprox@gmail.com'),
  ];

  final String chatButtonText = 'My AI chatbot';
  final String chatTitle = 'AI Chatbot';
  final String chatEmptyMessage =
      "Hey there! Let's talk work. Ask about my skills, "
      "past experiences, how I can help you, etc.";
  final String chatFieldHint = 'Type something...';

  late final Map<HomeTab, String> homeTabTitles = Map.fromEntries(
    HomeTab.values.map(
      (e) => MapEntry(e, switch (e) {
        HomeTab.about => 'About',
        HomeTab.skills => 'Tech Stack',
        HomeTab.projects => 'Projects',
      }),
    ),
  );

  InlineSpan about({TextStyle style = const TextStyle()}) => _textToSpan(
    style,
    [
      "I'm a",
      {"Flutter"},
      "developer with a background in",
      {"Android"},
      "(Java/Kotlin) and experience across mobile, web, and",
      {"backend"},
      "technologies. I started my journey in Android development",
      ..._tooltipSpan(
        style: style,
        text: switch ((DateTime.now().year - 2016 - 10).sign) {
          -1 => "nearly a decade ago",
          0 => "a decade ago",
          1 => "over a decade ago",
          int() => throw UnimplementedError(),
        },
        tooltip: """
switch ((DateTime.now().year - 2016 - 10).sign) {
  -1 => "nearly a decade ago",
  0 => "a decade ago",
  1 => "over a decade ago",
}
""",
        tooltipKey: "decade",
      ),

      ///
      ", gradually expanding into other areas which"
          " helped me better understand and build complete systems. Over time, Flutter became"
          " my main focus, and I've since worked on cross-platform apps for both mobile and",
      {"web"},
      ".\n\nI enjoy solving problems carefully, building maintainable solutions, and",
      {"automating"},
      "repetitive tasks whenever possible. My past experience in other parts of the stack"
          " often helps me see the bigger picture and write more thoughtful code. ",
      "I'm practical, curious, and always looking to",
      {"learn"},
      "something useful — especially when it makes future work easier or more robust.",
    ],
  );

  late final List<Skill> skills =
      <Skill>[
        ///
        (word: 'Flutter', weight: 50, group: 1),
        (word: 'Dart', weight: 45, group: 1),
        (word: 'Bloc', weight: 25, group: 1),
        (word: 'MVVM', weight: 25, group: 1),
        (word: 'Provider', weight: 25, group: 1),
        (word: 'Cross-platform', weight: 20, group: 1),
        (word: 'Performance Testing', weight: 15, group: null),
        (word: 'Secure Storage', weight: 15, group: null),
        (word: 'Responsive', weight: 10, group: null),

        ///
        (word: 'Android', weight: 40, group: 2),
        (word: 'Java', weight: 40, group: 2),
        (word: 'Kotlin', weight: 35, group: 2),
        (word: 'Android Jetpack', weight: 20, group: 2),
        (word: 'Gradle', weight: 20, group: 2),
        (word: 'Rx', weight: 25, group: 2),
        (word: 'SQLite', weight: 30, group: 2),
        (word: 'Google Services', weight: 15, group: null),
        (word: 'Push Notification', weight: 10, group: null),

        ///
        (word: 'Web', weight: 20, group: 3),
        (word: 'HTTP', weight: 20, group: 3),
        (word: 'HTML5', weight: 25, group: 3),
        (word: 'CSS', weight: 25, group: 3),
        (word: 'JavaScript', weight: 30, group: 3),
        (word: 'jQuery', weight: 20, group: 3),
        (word: 'PWA', weight: 10, group: null),

        ///
        (word: 'PHP', weight: 40, group: 4),
        (word: 'Laravel', weight: 35, group: 4),
        (word: 'RESTful API', weight: 25, group: 4),
        (word: 'MySQL', weight: 35, group: 4),
        (word: 'JWT', weight: 10, group: null),
        (word: 'OAuth', weight: 10, group: null),

        ///
        (word: 'C#', weight: 25, group: 5),
        (word: '.NET', weight: 25, group: 5),
        (word: 'WebSockets', weight: 10, group: null),

        ///
        (word: 'Git VCS', weight: 25, group: 6),
        (word: 'Unit Testing', weight: 25, group: 6),
        (word: 'Integration Testing', weight: 25, group: 6),
        (word: 'Gitlab CI', weight: 20, group: 6),
        (word: 'Docker', weight: 20, group: 6),
        (word: 'Material Design', weight: 20, group: 6),
        (word: 'Bash Scripting', weight: 20, group: 6),
        (word: 'Automation', weight: 20, group: 6),
        (word: 'CI/CD Pipelines', weight: 10, group: null),
        (word: 'Test-Driven Development', weight: 10, group: null),
      ].also((List<Skill> skills) {
        ///
        if (skills.isEmpty) return skills;

        final minMax = skills.fold(
          <double>[skills.first.weight, skills.first.weight],
          (p, s) => [
            min(p[0], s.weight),
            max(p[1], s.weight),
          ],
        );

        final diff = minMax[1] - minMax[0];

        return skills
            .map<Skill>(
              (s) => (
                word: s.word,
                weight: minMax[0] + (s.weight * Curves.easeIn.transform((s.weight - minMax[0]) / diff)),
                group: s.group,
              ),
            )
            .toList();
      });

  final String projectGalleryButtonText = 'View Images';

  late final List<Project> projects = <Project>[
    (
      title: 'Bikar - Job Finder App',
      description: (style) => _textToSpan(
        style,
        [
          "Developed the",
          {"Android"},
          " app for a job advertising application, implemented natively using",
          {"Java"},
          ". My primary role involved translating UI/UX designs into a functional and",
          "interactive user interface. The application allowed users to",
          {"browse job positions"},
          "through both an interactive Google Map view and a traditional list view,",
          "complemented by various filtering options. As one of my early career projects,",
          "it helped me gain more foundational experience in Android UI development,",
          "handling dynamic data presentation, and integrating core Android components",
          "for a user-centric application.",
        ],
      ),
      imageAssets: {},
      links: [],
    ),
    (
      title: 'Raha - Addiction Support App',
      description: (style) => _textToSpan(
        style,
        [
          "My role was to develop the whole app, from the",
          {"Android (Java)"},
          "side to building the",
          {"PHP backend"},
          "for content delivery and managing user interactions. I developed an application",
          "designed to assist individuals for",
          {"addiction recovery"},
          "by providing scheduled tasks, positive reinforcement messages, and a community chat feature.",
          //
          "\n\nKey features and challenges I tackled included:",
          "\n\t• Dynamic Content Display: Implementing robust methods to render HTML content directly within",
          "the app for rich text messages and educational materials.",
          "\n\t• Users Communication: Developing a text-based chat room to provide peer support among users.",
          "\n\t• User Engagement: Integrating notifications for timely task reminders and motivational messages.",
          "\n\t• Multimedia Playback: Incorporating media playing capabilities for media content.",
          //
          "\n\nThis project expanded my experience in full-stack mobile application development,",
          "demanding abilities to handle structured data flow between a mobile",
          "client and a backend.",
        ],
      ),
      imageAssets: {},
      links: [],
    ),
    (
      title: 'ClinicIr - Medical Appointment Booking',
      description: (style) => _textToSpan(
        style,
        [
          "Contributed to the development of an",
          {"Android (Java)"},
          "application designed for",
          {"booking appointments"},
          "with medical centers and individual doctors. My responsibilities focused on",
          "the implementation of user interface screens and associated functionalities.",
          //
          "\n\nDuring this project, I gained experience in:",
          "\n\t• Designing and building user flows for appointment scheduling and Browse.",
          "\n\t• Developing responsive UI components tailored for medical service interactions.",
          "\n\t• Integrating with data sources for displaying doctor information and available slots.",
          //
          "\n\nThis project allowed me to improve my skills in Android UI development",
          "and contribute to a complex, data-driven application within the healthcare domain.",
        ],
      ),
      imageAssets: {},
      links: [],
    ),
    (
      title: "Vitrynet - Online Shop",
      description: (style) => _textToSpan(
        style,
        [
          "I developed a complete platform for visual product discovery, providing an",
          {"Android (Java)"},
          "application, a",
          {"PHP/MySQL"},
          "backend, and a public-facing landing page",
          {"(HTML/CSS/JS)"},
          //
          ".\n\nAndroid Application:",
          "\n\t• Developed an Android application enabling users to identify and",
          "request products by uploading images and tagging the desired items.",
          "\n\t• Implemented a UI design, including a dynamic, scrollable product feed",
          "with varying item dimensions (similar to Pinterest's explore page).",
          "\n\t• Implemented a custom Android view to facilitate image tagging and display tag",
          "information interactively.",
          //
          "\n\nBackend & Web:",
          "\n\t• Designed and built a PHP/MySQL backend to manage product requests, shop listings, and",
          "communication between users and shops.",
          "\n\t• Created a landing page to introduce the app and its functionalities to potential users",
          "and shop owners.",
          //
          "\n\nThis project required abilities to manage the entire software development lifecycle,",
          "from conceptualization and UI/UX design to front-end and back-end implementation. I gained",
          "valuable experience in building complex Android applications, designing custom UI",
          "elements, and developing a full-stack solution.",
        ],
      ),
      imageAssets: {},
      links: [],
    ),
    (
      title: 'Elip - Isfahan Municipality Bike Share',
      description: (style) => _textToSpan(
        style,
        [
          "I was a",
          {"lead Android developer"},
          "for a comprehensive",
          {"smart mobility platform"},
          ", implementing both",
          {"first and fourth-generation bike-sharing systems"},
          "for Isfahan municipality, alongside solutions for electric cars",
          ..._tooltipSpan(
            style: style /*.copyWith(decoration: TextDecoration.underline)*/,
            text: [
              ..."(Naqsh-e Jahan Square".split(" ").map((t) => TextSpan(text: t)),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Icon(Icons.info, size: (style.fontSize ?? 17) * 0.85, color: style.color),
              ),
            ],
            tooltip: WidgetSpan(child: Image.asset("assets/images/naqshjahan.jpg", width: 250, height: 250)),
            tooltipKey: "Square",
          ),
          "and",
          ..._tooltipSpan(
            style: style /*.copyWith(decoration: TextDecoration.underline)*/,
            text: [
              ..."Chaharbagh Boulevard".split(" ").map((t) => TextSpan(text: t)),
              TextSpan(
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Icon(Icons.info, size: (style.fontSize ?? 17) * 0.85, color: style.color),
                  ),
                  TextSpan(text: ")"),
                ],
              ),
            ],
            tooltip: WidgetSpan(child: Image.asset("assets/images/chaharbagh.jpg", width: 250, height: 250)),
            tooltipKey: "Boulevard",
          ),
          "and internal operations. This multi-sided",
          "project involved developing multiple Android applications (operator, supervisor,",
          "repairman, driver, and client), integrating with",
          {"external hardware"},
          "via Bluetooth, and handling complex business logic. My role included",
          "significant UI/UX development, API integration, and effective system",
          {"debugging"},
          "strategies.",
          //
          {"\n\nPhase 1: First-Generation Bike Sharing (docking) & Operational Apps"},
          "\nIn the initial phase, I developed a suite of internal Android applications",
          "to manage a station-based bike-sharing system:",
          //
          "\n\t• Operator App: Engineered an Android application for station operators",
          "to manage customer registration (fingerprint authentication via connected",
          "hardware using Android APIs along with ID photo capture), bike issuance,",
          "swaps, delay handling, etc..",
          //
          "\n\t• Division Apps: Apps for repair personnel to check assigned tasks on map",
          "and streamlining maintenance operations, electric car drivers to manage passenger",
          "boarding, and supervisors to monitor and manage the system.",
          //
          "\n\t• Problem-Solving & System Enhancement: Throughout the project, I proactively",
          "addressed operational challenges by developing an in-app logging mechanism that",
          "sent detailed diagnostic information to the backend, drastically reducing",
          "debugging time of the whole project and allowing for rapid identification and",
          "resolution of operator-reported issues.",
          //
          {"\n\nPhase 2: Fourth-Generation Bike Sharing (Customer App)"},
          "\nThe second phase involved building a dock-less bike-sharing system for customers,",
          "where bikes could be rented and left anywhere in the city:",
          //
          "\n\t• Client App (Android): Implemented the app for the customers, enabling",
          "them to locate nearby bikes on a map, acquire them by unlocking the smart locks",
          "and handle the rest of operations.",
          //
          "\n\t• Smart Lock Integration: Established and configured the Bluetooth and online",
          "communication protocol with smart bike locks, handling packet operations to enable remote",
          "unlocking directly from the Android app. This required extensive documentation review",
          "and direct technical connection with the lock manufacturer to fill documentation",
          "gaps.",
          "\n\nThis extensive project honed my skills in developing complex, interconnected mobile",
          "systems, integrating with external hardware (Bluetooth, fingerprint devices), and creating",
          "effective debugging and deployment strategies in a real-world, high-stakes environment.",
        ],
      ),
      imageAssets: {
        "assets/images/image7.jpg",
        "assets/images/image18.jpg",
        "assets/images/image29.jpg",
        "assets/images/image34.jpg",
        "assets/images/image39.jpg",
      },
      links: [(title: "Official Video", url: "https://www.aparat.com/v/d1447q7")],
    ),
    (
      title: "Net - Isfahan Transportation Deputy's Maintenance System",
      description: (style) => _textToSpan(
        style,
        [
          "I designed, developed, and implemented a comprehensive",
          {"Maintenance and Monitoring Platform"},
          "for Isfahan's Deputy of Transportation and Traffic, enabling management of diverse",
          "physical assets across their network, from traffic & IT infrastructure to vehicles.",
          "This advanced system utilized a",
          {"tree-structure model"},
          "for defining system assets , supporting functionalities like real-time status checks,",
          "issue creation, and lifecycle management. The project involved",
          {"full-stack"},
          "ownership, where I built underlying backend",
          {"(PHP)"},
          ", the core",
          {"web application"},
          "for administration, and the",
          {"Android (Java)"},
          "application for field repairmen.",
          //
          "\n\n\t• Complex Data Modeling:",
          "\nImplemented a sophisticated system that allowed for defining customizable, hierarchical",
          "patterns of systems and creating instances of these tree-structured patterns. This",
          "included supporting dynamic modifications to instance structures (e.g., replacing sub-parts)",
          "and tracking their locations.",
          //
          "\n\n\t• Core Application:",
          "\nI implemented the software core using PHP for backend working with a MySQL",
          "database, along with the front-end web application to handle administration and",
          "monitoring based on different user levels.",
          //
          "\n\n\t• Repairman Mobile Application (Android):",
          "I developed the Android application (using Java) for field repairmen, integrating",
          "it with the backend. This app provided a map-based interface to visualize assets",
          "needing attention and navigate to their locations, and dynamic task management, allowing",
          "repairmen to receive, view, and update assigned tasks (e.g., issues, replacements, scheduled",
          "maintenance) in real-time.",
          //
          "\n\nDuring my tenure, this platform served as a highly effective and fully functional showcase",
          "for the network's maintenance and monitoring needs. It successfully demonstrated the",
          "capability to streamline their operations. This project truly solidified my expertise in",
          "end-to-end full-stack development, complex system design, geospatial application development,",
          "and building robust, scalable solutions for critical real-world challenges.",
        ],
      ),
      imageAssets: {},
      links: [],
    ),
    (
      title: "Gofta Media - Audio-Based Social Media Platform",
      description: (style) => _textToSpan(
        style,
        [
          "As a full-stack developer I designed and developed an audio social media platform,",
          "handling aspects from backend (Laravel) to mobile (Flutter). This project required abilities to build a",
          "complete application ecosystem from the ground up as a full-stack developer.",
          //
          "\n\nFlutter Mobile Application:",
          "\nI Developed the cross-platform mobile application using Flutter and",
          "implemented core social media functionalities to allow users to share audio posts.",
          //
          "\n\nLaravel (PHP) Backend:",
          "\nBuilt the backend using Laravel, responsible for managing user accounts,",
          "audio content, comments, and authentication flows.",
          //
          "\n\nThis project solidified my expertise in full-stack application development, specifically",
          "demonstrating proficiency in Flutter for mobile UI/logic, Laravel for robust backend services, MySQL for",
          "data management, and secure authentication methods.",
        ],
      ),
      imageAssets: {
        "assets/images/image35.jpg",
        "assets/images/image43.jpg",
      },
      links: [],
    ),
    (
      title: "Modiseh - E-commerce Application",
      description: (style) => _textToSpan(
        style,
        [
          "I developed a smooth front-end",
          {"cross-platform"},
          "(Android, iOS, PWA)",
          {"e-commerce application"},
          "using",
          {"Flutter"},
          ", designed for deployment across Android, iOS, and as a Progressive Web App (PWA).",
          //
          {"\n\nKey Features & Technical Contributions:"},
          "\n\t• Robust Product Catalog: Implemented intuitive and dynamic browse capabilities",
          "for a diverse product catalog.",
          "\n\t• Advanced Search & Filtering: Developed sophisticated search functionalities with",
          "dynamic filtering options to enhance product discovery.",
          "\n\t• Shopping Flow: Engineered the seamless e-commerce journey, e.g.",
          "shopping cart management, checkout and payment flows.",
          "\n\t• Clean Architecture: Delivered a clean and maintainable Flutter project, adhering",
          "to best practices for code organization, state management, and reusability.",
          //
          "\n\nThis project significantly strengthened my expertise in building production-ready",
          "front-end Flutter applications for complex domains like e-commerce. It highlights my",
          "ability to deliver feature-rich, user-centric mobile experiences suitable for",
          "multi-platform deployment.",
        ],
      ),
      imageAssets: {
        "assets/images/image5.jpg",
        "assets/images/image25.jpg",
        "assets/images/image27.jpg",
        "assets/images/image31.jpg",
      },
      links: [(title: "modiseh.com", url: "https://www.modiseh.com")],
    ),
    (
      title: "MomoBob - Parenting Guide",
      description: (style) => _textToSpan(
        style,
        [
          "As a",
          {"Flutter"},
          "developer I contributed to the development of a",
          {"content-based"},
          "application aimed",
          "at educating and supporting parents on child development. This",
          {"cross-platform"},
          "application,",
          "targeting Android, iOS, and PWA, included features like content delivery, forum and monitoring",
          "different stages of child growth.",
          //
          {"\n\nKey Features & Contributions:"},
          "\n\t• Diverse Content Delivery: Robust modules for displaying various content types, including",
          "in-app video playback and rendering HTML content within posts, ensuring rich and engaging educational materials.",
          "\n\t• Community Engagement: Developed a forum section to foster a supportive community where parents could",
          "interact, share experiences, and seek advice.",
          "\n\t• Data Visualization & Tracking: Built functionalities for presenting charts and statistics,",
          "alongside a system for tracking child milestones, providing parents with visual insights into their child's progress.",
          "\n\t• Proactive Notifications: Integrated a notification system to deliver timely alerts and",
          "reminders to parents at specific, crucial moments in their child's development journey.",
          //
          "\n\nThis project significantly enhanced my expertise in collaborative Flutter development within an",
          "agile environment. It solidified my skills in implementing complex UI, managing diverse content",
          "types, integrating interactive data visualizations, and developing",
          "community features for a content-driven mobile application.",
        ],
      ),
      imageAssets: {
        "assets/images/image2.jpg",
        "assets/images/image10.jpg",
        "assets/images/image15.jpg",
        "assets/images/image36.jpg",
      },
      links: [(title: "Introduction Video", url: "https://www.aparat.com/v/zPrZa")],
    ),
    (
      title: "Damsun CRM - CRM & Operations Platform",
      description: (style) => _textToSpan(
        style,
        [
          "As a dedicated",
          {"Flutter"},
          "developer, I was the sole front-end engineer responsible for building a",
          {"CRM"},
          "and Operations Platform. I developed the cross-platform application - targeting",
          {"Android & Web"},
          "- designed to streamline core business processes across different departments.",
          "The project consisted of",
          {"ticketing system"},
          ", workflow handling,",
          {"sales management"},
          ", administration, etc..",
          //
          "\n\n\t• Attendance Management System (HR Integration):",
          "Implemented intuitive enter/exit forms incorporating identification mechanisms (e.g.",
          "camera identification) for employees and reports for viewing attendance statistics and",
          "historical data.",
          //
          "\n\n\t• Ticketing & Workflow System:",
          "Implemented the user interface for a ticketing system, allowing users to create, track,",
          "and manage service requests based on dynamic workflows.",
          //
          "\n\n\t• Sales & Customer Relationship Management:",
          "Developed the front-end for the sales module, supporting the end-to-end sales cycle from",
          "customer definition to managing departmental tasks within the sales pipeline.",
          //
          "\n\n\t• Technical Excellence & Collaborative Environment:",
          "This project involved translating intricate business logic and workflows into a clean,",
          "highly functional, and intuitive Flutter application. I focused on delivering a",
          "clean and maintainable Flutter codebase, ensuring scalability and responsiveness.",
          //
          "\n\nThis project demonstrated my proven ability to develop enterprise applications, manage",
          "complex state, handle diverse user roles, and integrate with dynamic backend services.",
        ],
      ),
      imageAssets: {},
      links: [],
    ),
  ].reversed.toList();

  /// [texts] items either [String] or single-element [Set] (bold) or instance of [InlineSpan] or null (ignored)
  InlineSpan _textToSpan(TextStyle style, Iterable<dynamic> texts, [String? join = ' ']) {
    texts = texts.map(
      (e) => e is Set
          ? TextSpan(
              text: e.first,
              style: style.copyWith(fontWeight: FontWeight.w900, color: titleColor),
            )
          : e,
    );

    Iterable<InlineSpan> spans = texts.nonNulls.map(
      (e) => switch (e) {
        InlineSpan e => e,
        Object() => TextSpan(text: e.toString(), style: style),
      },
    );

    return TextSpan(
      style: style,
      children: join == null
          //
          ? spans.toList()
          : spans.joinWith((_, __) => TextSpan(text: join, style: style)).toList(),
    );
  }

  final Map<dynamic, (GlobalKey<TooltipState>, int)> _tooltipKeys = {};

  /// Makes a tooltip that is shown by hover/tap
  /// [key] must be unique for each piece of text
  /// [text] must be either [String] (divided by ' ') or [Iterable<InlineSpan>]
  /// [tooltip] must be either [String] or [InlineSpan]
  ///
  /// https://github.com/flutter/flutter/issues/51587
  ///
  /// 'this is a text' => ['this', 'is', 'a', 'text'] with tooltips
  Iterable<InlineSpan> _tooltipSpan({
    required TextStyle style,
    required dynamic text,
    required dynamic tooltip,
    required dynamic tooltipKey,
  }) {
    /// If not divided, the whole text will be one Widget, no line break, etc.
    final parts = List<dynamic>.from(text is String ? text.trim().split(' ') : text);

    return parts.mapIndexed(
      (index, e) {
        final Widget t = e is String ? Text(e, style: style) : Text.rich(e, style: style);

        return WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: DisposableWidget<GlobalKey<TooltipState>>(
            getValue: () {
              var k = _tooltipKeys[tooltipKey];
              if (k == null) {
                k = (GlobalKey(), 1);
              } else {
                k = (k.$1, k.$2 + 1);
              }
              _tooltipKeys[tooltipKey] = k;
              return k.$1;
            },
            disposeFunction: (_) => (() {
              final k = _tooltipKeys[tooltipKey];
              if (k == null) return;
              final c = k.$2 - 1;
              _tooltipKeys[tooltipKey] = (k.$1, c);
              if (c <= 0) _tooltipKeys.remove(tooltipKey);
            }),
            builder: (context, tooltipKey) => GestureDetector(
              onTap: () => tooltipKey.currentState?.ensureTooltipVisible(),
              child: MouseRegion(
                onHover: (_) => tooltipKey.currentState?.ensureTooltipVisible(),
                onExit: (_) => Tooltip.dismissAllToolTips(),
                child: (index != parts.length - 1)
                    ? t
                    : Tooltip(
                        key: tooltipKey,
                        triggerMode: TooltipTriggerMode.manual,
                        // message: tooltip,
                        richMessage: tooltip is InlineSpan ? tooltip : TextSpan(text: tooltip.toString()),
                        child: t,
                      ),
              ),
            ),
          ),
        );
      },
    );
  }

  void dispose() {}
}

// class Errors {
//   Errors._();
//
//   static Errors instance = Errors._();
//
//   factory Errors() => instance;
//   //
//   String urlLaunchError() => "Can't open url";
// }
//
// final Errors errors = (urlLaunchError: "Can't open url");
