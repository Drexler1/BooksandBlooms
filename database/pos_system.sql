-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 23, 2026 at 04:17 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pos_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `admin_id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  `full_name` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `username_hash` varchar(64) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`admin_id`, `username`, `password`, `full_name`, `email`, `username_hash`, `password_hash`) VALUES
(6, 'P7dCrVxAz3SOqwaiIhI1HrSa3vXxpB6c1A6Y/Egs8Uc=', 'bZVh2/8PHmuLPt7zBLYBkfsZEALgxw2uVYkckgi0eWQ=', 'ZNK4Tl8TtHhCItgV/PXM/6pk805FY25hC2VXeR1Me+0=', 'NE8Yp1RvT3aj6ANAMaH7w8hSpFOSz8N0qjkWG9LRSCnhl8byJza80kC88JUGCvAD', '715004213ff39151819aea6a5256a3c89d4d4f88ca1077f4081fae623be06b1b', '$2b$12$MvTQp.wE5IB6Wquw1VqlM.WPYkE3QwLZVLuXeuYoGMo5.lTws7i5W');

-- --------------------------------------------------------

--
-- Table structure for table `app_settings`
--

CREATE TABLE `app_settings` (
  `setting_key` varchar(100) NOT NULL,
  `setting_value` varchar(500) NOT NULL DEFAULT '',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `app_settings`
--

INSERT INTO `app_settings` (`setting_key`, `setting_value`, `updated_at`) VALUES
('late_grace_minutes', '10', '2026-05-19 13:49:20'),
('late_per_minute_rate', '0.7500', '2026-05-24 04:55:32');

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `attendance_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `shift_type` varchar(50) DEFAULT NULL,
  `clock_in` datetime DEFAULT NULL,
  `clock_out` datetime DEFAULT NULL,
  `attendance_date` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `hours_worked` decimal(10,4) NOT NULL DEFAULT 0.0000,
  `hourly_rate_snapshot` decimal(10,2) NOT NULL DEFAULT 0.00,
  `daily_earnings` decimal(10,2) NOT NULL DEFAULT 0.00,
  `pay_period_start` date DEFAULT NULL,
  `pay_period_end` date DEFAULT NULL,
  `daily_pay` decimal(10,2) DEFAULT NULL,
  `late_minutes` int(11) NOT NULL DEFAULT 0,
  `late_deduction` decimal(10,2) NOT NULL DEFAULT 0.00,
  `deduction_waived` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`attendance_id`, `employee_id`, `shift_type`, `clock_in`, `clock_out`, `attendance_date`, `created_at`, `hours_worked`, `hourly_rate_snapshot`, `daily_earnings`, `pay_period_start`, `pay_period_end`, `daily_pay`, `late_minutes`, `late_deduction`, `deduction_waived`) VALUES
(10, 12, '8AM', '2026-08-18 00:27:41', '2026-08-18 23:59:00', '2026-08-18', '2026-08-17 16:27:41', 23.5219, 38.50, 905.59, '2026-08-16', '2026-08-31', NULL, 0, 0.00, 0);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(80) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `name`, `created_at`) VALUES
(53, 'Coffee', '2026-08-05 14:56:04'),
(59, 'Pasta & Snacks', '2026-08-10 14:46:07'),
(60, 'Combo Meals', '2026-08-11 05:06:29'),
(61, 'Rice Meals', '2026-08-11 05:07:35'),
(62, 'Cakes & Pastries', '2026-08-11 05:09:00'),
(63, 'Ala Carte', '2026-08-11 05:26:01');

-- --------------------------------------------------------

--
-- Table structure for table `email_alert_settings`
--

CREATE TABLE `email_alert_settings` (
  `id` int(11) NOT NULL,
  `smtp_host` varchar(255) NOT NULL DEFAULT '',
  `smtp_port` smallint(6) NOT NULL DEFAULT 587,
  `smtp_user` varchar(255) NOT NULL DEFAULT '',
  `smtp_password` varchar(255) NOT NULL DEFAULT '',
  `smtp_use_tls` tinyint(1) NOT NULL DEFAULT 1,
  `alert_recipient` varchar(255) NOT NULL DEFAULT '',
  `low_stock_enabled` tinyint(1) NOT NULL DEFAULT 1,
  `low_stock_threshold` int(11) NOT NULL DEFAULT 5,
  `daily_summary_enabled` tinyint(1) NOT NULL DEFAULT 1,
  `daily_summary_time` varchar(5) NOT NULL DEFAULT '22:30',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `overtime_request_enabled` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `email_alert_settings`
--

INSERT INTO `email_alert_settings` (`id`, `smtp_host`, `smtp_port`, `smtp_user`, `smtp_password`, `smtp_use_tls`, `alert_recipient`, `low_stock_enabled`, `low_stock_threshold`, `daily_summary_enabled`, `daily_summary_time`, `updated_at`, `overtime_request_enabled`) VALUES
(1, 'smtp.gmail.com', 587, 'patrimoniodrexler1@gmail.com', 'nlpx zczw mcgv xhzg', 1, 'patrimoniodrexler1@gmail.com', 1, 2, 1, '10:20', '2026-08-04 17:48:15', 1);

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `employee_id` int(11) NOT NULL,
  `application_id` int(11) DEFAULT NULL,
  `full_name` varchar(255) NOT NULL DEFAULT '',
  `username` varchar(255) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  `role` enum('admin','manager','cashier') NOT NULL DEFAULT 'cashier',
  `employment_status` enum('active','inactive','terminated') DEFAULT 'active',
  `face_image_path` varchar(255) DEFAULT NULL,
  `face_model_path` mediumtext DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `disabled_at` datetime DEFAULT NULL,
  `username_hash` varchar(64) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `hourly_rate` decimal(10,2) NOT NULL DEFAULT 0.00,
  `email` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`employee_id`, `application_id`, `full_name`, `username`, `password`, `role`, `employment_status`, `face_image_path`, `face_model_path`, `last_login`, `created_at`, `disabled_at`, `username_hash`, `password_hash`, `hourly_rate`, `email`) VALUES
(12, NULL, 'mXVoRADMuSFCiUnSKV5SbK0NAtRIe9hn773Ky6JKBh4=', 'cZbXLTPS93bxBJJr17ws1Nze271keCRB7qdOXhO08B8=', '9KVjltpu6sAb5+1RblizcBA+hnx5VXRVoqXSzZSGWY0=', 'cashier', 'active', 'face_images/12.jpg', '{\"v\":1,\"emb\":[2.3687562147776284,0.8647989630699158,0.03313590089480082,2.136741836865743,0.7752622067928314,0.41590073704719543,-0.9312488039334615,0.12474623322486877,0.05042538046836853,-0.2774627357721329,1.2650719086329143,-0.25546811521053314,-0.317549208799998,-0.2125775491197904,-0.21207414070765176,-0.5774228150645891,1.568404197692871,1.7844852606455486,-0.4437282482783,1.2618485291798909,-1.206986705462138,0.7416401306788126,0.8629148006439209,-0.9457627137502035,-0.6060678102076054,0.41993163029352826,1.3160210847854614,0.4315634419520696,1.9039789040883381,0.029765757421652477,0.18134957551956177,0.4619000752766927,-1.078917920589447,0.7470542192459106,0.11918141071995099,-1.2451130747795105,-1.115052878856659,-1.7627748648325603,-0.3848794599374135,0.7617415984471639,0.28527918457984924,-0.9247864484786987,0.3285820186138153,-0.04605088010430336,-0.560092935959498,0.29622844854990643,-0.7583642601966858,0.6985276142756144,-0.40480024615923565,0.23935174942016602,0.41973650455474854,-1.1077678402264912,0.9653153220812479,1.1678826808929443,0.282660777370135,-0.33811845382054645,-0.4713594615459442,-0.5289032285412153,1.049078365166982,0.36919460197289783,0.6950381795565287,0.6526063680648804,0.022183200034002464,1.133657991886139,0.5973583360513052,-0.22176676740249,-0.3283124566078186,-0.86594025293986,0.8783520460128784,-0.6882142027219137,-0.09615113586187363,1.2137281099955242,-0.7923490405082703,0.5111929078896841,0.38654888172944385,-1.1733675201733906,-0.7054888308048248,-1.3950388828913372,0.007010248800118764,-0.13297884352505207,1.4136487642923992,-0.2368073413769404,-1.5717724164326985,0.5190525352954865,1.0474546353022258,0.6868177254994711,0.5798132009804249,-0.5224156181017557,0.3802384287118912,0.18732613325119019,0.5436590413252512,-0.7107356091340383,1.0071044564247131,-0.6550482312838236,0.006454338630040486,0.8219812512397766,-0.2502390493949254,1.5458882252375286,-0.8745375474294027,0.5846748451391856,-0.03478615110119184,0.8857760826746622,-0.2814446638027827,0.9985649387041727,0.036442503333091736,-0.21325943867365518,0.260241170724233,-0.4230205367008845,-0.15056744466225305,0.7532529234886169,1.3256587187449138,-0.9425132572650909,-0.6469644382596016,-0.34069211532672244,-0.7002798020839691,-0.38491940932969254,-0.2170573572317759,-0.28306542336940765,-1.257513443628947,0.8729663093884786,0.7095851600170135,1.900714119275411,-1.2759838104248047,-1.0020496050516765,-1.210315426190694,-1.7597169478734334,1.6617279450098674,-2.0174028078715005,-0.27879081666469574,1.3878828287124634,-1.1464510162671406,-0.6339807560046514,-0.2813882889846961,0.005529281993707021,-1.8864936033884685,0.05317352215449015,-1.2810783783594768,-1.592781901359558,1.496571699778239,2.6471898555755615,1.6840649048487346,0.659360388914744,-0.11989982922871907,0.10643865664800008,0.2575064996878306,-0.16481858491897583,0.019278861582279205,0.20101860538125038,-0.218217677436769,-1.1592557032903035,1.9493616024653118,1.2641388575236003,-0.5471287667751312,1.7392794688542683,0.8173045516014099,-1.3113421599070232,-1.502892017364502,-0.5414739648501078,-1.0151225129763286,-0.7769367297490438,0.992924153804779,1.2539922992388408,0.28176917135715485,0.9109343687693278,0.2716805587212245,0.3022455225388209,-0.32069747149944305,0.4455610662698746,-1.6080903609593709,0.7611515820026398,-1.3122148513793945,1.0215295155843098,0.3039989074071248,0.355826993783315,1.8328380187352498,1.1611182292302449,-0.9289249380429586,1.2682740290959675,-0.14630700089037418,0.9032910068829855,-0.49339375893274945,-0.03732986996571223,-1.4219492276509602,-0.6605256994565328,1.2073082129160564,0.35977665583292645,0.672091526289781,-0.4158116827408473,0.4789181749025981,1.4984807968139648,0.09350350499153137,1.2237672209739685,1.0217565099398296,-2.02559487024943,0.5622081756591797,-0.12102197234829266,-2.2008897066116333,-0.9674349824587504,1.862028996149699,-1.3722776571909587,1.6943642695744832,-0.14756982028484344,0.48477598031361896,-0.1917316516240438,1.3718857963879902,-0.4942459960778554,-0.14772743980089822,0.3732433021068573,-0.05247251192728678,2.054380178451538,-1.2524825533231099,-1.0746046702067058,-0.08243945240974426,0.12831149995326996,-0.9857392907142639,1.1229390303293865,-0.08786119520664215,0.5876415173212687,-2.0095091660817466,0.6710363527139028,0.003736425812045733,-0.8796001474062601,0.4470075766245524,1.0823039412498474,0.06880225737889607,0.9841923912366232,0.5551011065642039,0.7852391451597214,0.290983388821284,-0.32245015104611713,1.270600418249766,-1.312937577565511,0.5677700266242027,-2.275923569997152,-1.1846218903859456,-0.4693592389424642,-1.9604082902272542,1.6795815229415894,1.24564528465271,1.1543515523274739,-0.05227969090143839,-0.7124704321225485,-0.1997053325176239,-0.45853004852930707,1.0831884344418843,1.331707239151001,-0.7233731846014658,-0.5708982199430466,0.576985239982605,0.9593807458877563,-0.6649481058120728,0.9975700974464417,1.1081406672795613,0.11298029621442159,0.008440037568410238,0.4761063481370608,-0.2508124423523744,1.1891350547472637,0.292096679409345,0.5318959554036459,-1.1332443356513977,-0.04860183844963709,0.9914196332295736,-2.1333704392115274,0.46270652115345,-1.8473312854766846,-0.16911619529128075,0.8204822341601054,-0.6589938004811605,-1.889108379681905,1.1273735364278157,0.2786290595928828,2.3514114220937095,0.08666553099950154,0.7343396544456482,2.394071022669474,-0.5176986753940582,-0.38060448070367175,0.14172855019569397,1.2829959789911907,-0.09768564502398173,1.4167337814966838,-2.027137796084086,0.06310361251235008,-1.0123724540074666,-0.979098359743754,-0.8161724805831909,1.7364832162857056,-0.40698571130633354,1.3979204495747883,-1.363023042678833,-1.4153138001759846,-0.3634372105201085,0.13020785308132568,1.0770576000213623,-0.5471976399421692,-1.6906973520914714,-0.4636165151993434,-0.4355281988779704,-2.0373562574386597,0.863631029923757,-0.4470447500546773,0.01355667474369208,-0.4158481111129125,0.21309131383895874,-0.715047299861908,1.4581434329350789,0.253156046072642,-1.1939395467440288,0.17058094094196954,-0.743202269077301,0.04864151279131571,0.42553851505120593,1.3261111577351887,1.8936971028645833,0.13957256575425467,-0.3718217611312866,-0.11445938299099605,1.663850982983907,0.031102662906050682,0.9600306153297424,-1.0954432884852092,1.0729488730430603,1.474176049232483,-0.05510111339390278,-0.620974600315094,-0.6877067188421885,1.5904533465703328,-0.47630754113197327,-0.22182476396361986,0.32817187905311584,-0.2335150994670888,-0.40862808128197986,0.6751651590069135,1.5080150763193767,1.6504363616307576,0.7024354338645935,-0.8470109601815542,-0.2342593545715014,0.33861617216219503,0.7201147874196371,-0.27792689700921375,0.12815221461157003,-0.7491352756818136,0.9838412404060364,-0.06044331192970276,-0.4948801522453626,0.936285674571991,0.26118983794003725,0.909392793973287,0.06245038037498792,-0.6590864459673563,-0.006360810250043869,0.5140632515152296,-0.7243180672327677,0.30877519647280377,0.8275734583536783,0.10606594880421956,0.12461942620575428,0.5428218891223272,-0.5246865799029669,-0.9300785859425863,-0.17318545281887054,-0.3309552160402139,-0.4690554117163022,0.3757738570372264,-0.7834234237670898,-0.24606203784545264,-0.38625722130139667,-0.1687722752491633,-0.9379545847574869,-1.3396815061569214,-0.8914085825284322,0.1790597935517629,0.40751858055591583,2.3943885962168374,-0.7739095290501913,1.8558682203292847,-0.4798036913077037,0.18918449680010477,-0.9692073265711466,0.25268162538607913,-1.8441579341888428,0.5660277009010315,0.815285305182139,-1.01559313138326,-0.8471313118934631,1.9047359625498455,0.4443750660866499,-0.35623693466186523,0.1987452208995819,0.6418331066767374,-2.0722732543945312,0.695742686589559,-1.0665600697199504,-0.39911674956480664,0.2505890068908532,1.2055877049763997,0.04846572130918503,-1.3578946987787883,-0.359906738003095,0.5121124585469564,0.35787333237628144,0.4677752045293649,0.4855149487654368,-0.5767240524291992,-1.8657708168029785,-1.2726572354634602,0.7267745931943258,-0.12685763835906982,1.706802765528361,0.6606525381406149,0.7879512310028076,-0.5305108974377314,0.5341225763161978,-1.8401637474695842,0.6763116319974264,1.4590415557225545,0.19521776338418326,-0.719435582558314,1.0290691157182057,0.39316510160764057,-0.8157626390457153,0.6793331863979498,0.2096798432370027,0.5829227268695831,0.18026434599111477,-0.9185137947400411,0.47858842213948566,-1.0579397678375244,-0.7751494844754537,0.6264688769976298,-0.6616037984689077,-1.482596516609192,-0.11218139405051868,0.8018878698348999,-0.9207620223363241,-2.1985353231430054,-0.14622425039609274,0.5405282179514567,-1.0239913662274678,1.1510716478029888,-2.168933947881063,0.40936437373359996,-1.9433839321136475,0.46725686887900036,-0.4184735218683879,0.10314660271008809,-0.5588889817396799,-1.267805854479472,0.5160148317615191,-1.0728265245755513,0.44889501730600995,0.5531773169835409,0.23032348354657492,-0.052213301261266075,-0.600949615240097,0.26608775556087494,0.7488864262898763,1.0625632603963215,0.07615133871634801,1.2461761633555095,0.34427085022131604,1.7762715816497803,-0.7011582454045614,0.03256497710632781,1.5237266222635906,-2.983027696609497,1.351560393969218,0.3853274981180827,1.0942392945289612,-0.5646951546271642,0.9567058285077413,-1.4129077990849812,-0.9753608703613281,0.5780293246110281,1.2578051090240479,-0.2844383182624976,-0.03563781827688217,-0.1410712574919065,1.0218205849329631,1.809849778811137,0.017446651433904965,0.6771892507870992,-1.405367414156596,-1.2152289549509685,-1.2546309232711792,2.612706104914347,-0.6810745398203532,-1.4054489930470784,-0.463183656334877,-1.5432558059692383,-0.717117706934611,-0.5495195438464483,0.5629215737183889,-1.0948086182276409,-0.719692995150884,-0.005236536264419556,-0.06030469139417013,-0.3867165793975194,0.738827645778656,-0.26751403013865155,-0.656247466802597,-1.1696208715438843,-0.5451886157194773,0.18935510516166687,0.3281391461690267,0.24922105514754853,-0.03578385462363561,-1.809720794359843,0.899650514125824,-0.07777047902345657]}', '2026-08-23 09:47:05', '2026-08-07 03:29:11', NULL, 'c854f5718d1650ea6388d1c53188eca4a428ecb81656d4d93b1c5fe8df1eca57', '$2b$12$fAXrq/2bMhX12GiS1aSDlejUbhszBEu4PcIHXHZ5Z8DlVnOom1A2O', 38.50, 'jl+jQvelDDQyftqQTOApzaxd926AFk9f/RTw9Pf6/22bgIkCaAn4TltLbD6/hdzw');

-- --------------------------------------------------------

--
-- Table structure for table `employees_trash`
--

CREATE TABLE `employees_trash` (
  `trash_id` int(10) UNSIGNED NOT NULL,
  `employee_id` int(11) NOT NULL,
  `full_name` varchar(255) NOT NULL DEFAULT '',
  `username` varchar(255) NOT NULL DEFAULT '',
  `username_hash` varchar(64) DEFAULT NULL,
  `password` varchar(255) NOT NULL DEFAULT '',
  `password_hash` varchar(255) DEFAULT NULL,
  `role` enum('admin','manager','cashier') NOT NULL DEFAULT 'cashier',
  `face_image_path` varchar(255) DEFAULT NULL,
  `face_model_path` mediumtext DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `disabled_at` datetime NOT NULL DEFAULT current_timestamp(),
  `delete_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee_applications`
--

CREATE TABLE `employee_applications` (
  `application_id` int(11) NOT NULL,
  `full_name` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `username` varchar(255) NOT NULL DEFAULT '',
  `role` enum('admin','manager','cashier') NOT NULL DEFAULT 'cashier',
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `face_mismatch_log`
--

CREATE TABLE `face_mismatch_log` (
  `id` int(10) UNSIGNED NOT NULL,
  `employee_id` int(11) NOT NULL,
  `attempted_at` datetime NOT NULL DEFAULT current_timestamp(),
  `distance_score` float DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `face_mismatch_log`
--

INSERT INTO `face_mismatch_log` (`id`, `employee_id`, `attempted_at`, `distance_score`, `ip_address`, `user_agent`) VALUES
(1, 1, '2026-03-25 08:55:09', 0.6711, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(2, 1, '2026-03-25 08:55:32', 0.6885, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(3, 1, '2026-03-25 08:55:45', 0.7331, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(4, 1, '2026-03-25 12:33:22', 0.3156, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(5, 1, '2026-03-25 12:33:28', 0.8002, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(6, 1, '2026-03-25 12:33:43', 0.4578, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(7, 1, '2026-03-25 12:33:53', 0.4503, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(8, 1, '2026-03-25 12:33:58', 0.301, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(9, 1, '2026-03-25 12:34:04', 0.3761, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(10, 1, '2026-03-25 12:35:08', 0.4677, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(11, 2, '2026-03-25 12:36:56', 0.3106, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(12, 2, '2026-03-25 12:37:13', 0.367, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(13, 2, '2026-03-25 12:38:00', 0.4079, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(14, 2, '2026-03-25 12:38:14', 0.6877, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(15, 2, '2026-03-25 12:39:01', 0.3209, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(16, 2, '2026-03-25 12:39:20', 0.3051, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(17, 2, '2026-03-25 12:39:39', 0.7074, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(18, 2, '2026-03-25 12:42:29', 0.6511, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(19, 2, '2026-03-25 12:42:33', 0.6217, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(20, 2, '2026-03-25 12:42:35', 0.6179, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(21, 2, '2026-03-25 13:23:52', 0.6914, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(22, 2, '2026-03-25 13:24:06', 0.6406, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(23, 2, '2026-03-25 14:28:32', 0.662, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(24, 2, '2026-03-25 14:30:42', 0.6833, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(25, 2, '2026-03-25 15:00:52', 0.4435, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36'),
(26, 3, '2026-03-25 15:00:56', 0.5634, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36'),
(27, 3, '2026-03-25 15:01:08', 0.4741, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36'),
(28, 2, '2026-03-25 15:01:09', 0.4562, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36'),
(29, 3, '2026-03-25 15:01:19', 0.4432, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36'),
(30, 2, '2026-03-25 15:01:32', 0.4416, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36'),
(31, 3, '2026-03-25 15:19:36', 0.5779, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(32, 3, '2026-03-25 15:48:58', 0.6949, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36'),
(33, 3, '2026-03-25 16:27:39', 0.517, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(34, 5, '2026-03-26 07:41:25', 0.3381, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(35, 5, '2026-03-26 07:41:42', 0.6013, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(36, 5, '2026-03-26 07:45:05', 0.4796, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(37, 5, '2026-03-26 07:46:25', 0.8069, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(38, 3, '2026-03-27 00:14:49', 0.5249, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(39, 3, '2026-03-27 00:29:10', 0.5543, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(40, 3, '2026-03-27 00:29:46', 0.58, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(41, 3, '2026-03-27 00:30:47', 0.6344, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(42, 5, '2026-03-27 07:54:34', 0.5163, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(43, 3, '2026-03-31 23:38:48', 0.5825, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0'),
(44, 10, '2026-08-05 08:29:43', 0.3712, '127.0.0.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36');

-- --------------------------------------------------------

--
-- Table structure for table `inv_items`
--

CREATE TABLE `inv_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `type` enum('ingredient','packaging') NOT NULL DEFAULT 'ingredient',
  `stock` decimal(12,2) NOT NULL DEFAULT 0.00,
  `unit` varchar(20) NOT NULL DEFAULT 'pcs',
  `reorder_point` decimal(12,2) NOT NULL DEFAULT 10.00,
  `note` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inv_items`
--

INSERT INTO `inv_items` (`id`, `name`, `type`, `stock`, `unit`, `reorder_point`, `note`, `is_active`, `created_at`, `updated_at`) VALUES
(28, '8oz Cup', 'packaging', 1.00, '8oz', 20.00, 'Cup packaging — auto-deducted on sales', 1, '2026-08-05 14:55:15', '2026-08-05 15:02:38'),
(32, 'Sugar', 'ingredient', 1.00, 'kg', 10.00, NULL, 1, '2026-08-07 07:22:12', '2026-08-07 07:22:12');

-- --------------------------------------------------------

--
-- Table structure for table `inv_log`
--

CREATE TABLE `inv_log` (
  `log_id` int(10) UNSIGNED NOT NULL,
  `item_id` int(10) UNSIGNED NOT NULL,
  `item_name` varchar(120) NOT NULL DEFAULT '',
  `unit` varchar(20) NOT NULL DEFAULT 'pcs',
  `delta` decimal(12,2) NOT NULL,
  `stock_after` decimal(12,2) NOT NULL,
  `source` enum('sale','manual') NOT NULL DEFAULT 'manual',
  `transaction_id` int(10) UNSIGNED DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `created_by` varchar(80) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `login_attempts`
--

CREATE TABLE `login_attempts` (
  `attempt_key` varchar(64) NOT NULL,
  `fail_count` int(11) NOT NULL DEFAULT 0,
  `locked_until` datetime DEFAULT NULL,
  `last_attempt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `login_attempts`
--

INSERT INTO `login_attempts` (`attempt_key`, `fail_count`, `locked_until`, `last_attempt`) VALUES
('0aa4996eec69f205abce96013334f99d8083c84780047f1850c297218e71081e', 1, NULL, '2026-06-20 10:46:00'),
('0d7dce5d2cf9a848e0a85d2766071b72ce389c9142207a25335af3a785d3cd60', 1, NULL, '2026-06-20 10:46:04'),
('0f50b0d848d29f2476624f171dc2d442266e35bed28ad11e830d6cf09f2b0929', 3, NULL, '2026-04-04 14:34:07'),
('3049ea9e4b0a7b1b19db0afff84bc4434878d00c503dc9b9fa6a8a257c4f67e6', 4, NULL, '2026-03-26 11:36:53'),
('4801e744b254a7d1f0993a29705a151e7430e4355186ff79b51128baca15af53', 2, NULL, '2026-06-18 12:30:09'),
('85d636564759f084aae5de99f84bf6246f97cfea6c02769f55484c7eba9bec4d', 5, '2026-04-05 17:42:20', '2026-04-05 17:27:20'),
('a49a0bc44eb86fb946e61a404978255950b48af6daaaec520e2a6fdd8120104c', 1, NULL, '2026-04-24 15:00:51'),
('c6226336103d7f37ae7977cb2eaf934e6491d7fe3bebb358acf9e6a93384a342', 1, NULL, '2026-06-20 10:45:34'),
('caf6f36cd0b4ca60bb2d899d89d0dc0986c37b7ffe6f2d62c35186ceaa370657', 1, NULL, '2026-06-20 10:46:18'),
('d139604745a93e36066ef4338fb6d25123ef18fac7fd9e388a991c8cb4392670', 1, NULL, '2026-08-07 14:28:35'),
('e465bc3707ee26be69bd181efe4d44bc137e560e1a3ec977570c0037c0f17b79', 1, NULL, '2026-08-16 00:36:05'),
('e5a53f281f2cbc6dda2b870762a92947b3855ebe9e8e026b4de8f37c45d61c62', 2, NULL, '2026-06-20 10:45:45');

-- --------------------------------------------------------

--
-- Table structure for table `overtime_requests`
--

CREATE TABLE `overtime_requests` (
  `request_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `attendance_id` int(11) DEFAULT NULL,
  `request_date` date NOT NULL,
  `extended_hours` decimal(4,2) NOT NULL,
  `reason` varchar(500) NOT NULL DEFAULT '',
  `status` enum('pending','approved','denied','cancelled') NOT NULL DEFAULT 'pending',
  `reviewed_by` varchar(255) DEFAULT NULL,
  `reviewed_at` datetime DEFAULT NULL,
  `admin_note` varchar(500) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `overtime_requests`
--

INSERT INTO `overtime_requests` (`request_id`, `employee_id`, `attendance_id`, `request_date`, `extended_hours`, `reason`, `status`, `reviewed_by`, `reviewed_at`, `admin_note`, `created_at`) VALUES
(1, 10, NULL, '2026-05-27', 1.00, 'DELAY', 'denied', 'Drexler', '2026-05-27 19:28:19', '', '2026-05-27 11:27:41'),
(2, 10, NULL, '2026-05-27', 1.00, 'PLEASE', 'denied', 'Drexler', '2026-05-27 19:29:25', '', '2026-05-27 11:29:05'),
(3, 10, NULL, '2026-08-03', 1.00, 'extend 1 hour', 'cancelled', NULL, NULL, NULL, '2026-08-03 15:05:45'),
(4, 10, NULL, '2026-08-03', 1.00, 'extend 1', 'cancelled', NULL, NULL, NULL, '2026-08-03 15:09:41'),
(5, 10, NULL, '2026-08-03', 1.00, 'sample', 'cancelled', NULL, NULL, NULL, '2026-08-03 15:20:10'),
(6, 10, NULL, '2026-08-03', 1.00, '1', 'cancelled', NULL, NULL, NULL, '2026-08-03 15:20:41'),
(7, 10, NULL, '2026-08-03', 0.50, '1', 'cancelled', NULL, NULL, NULL, '2026-08-03 15:31:50'),
(8, 10, NULL, '2026-08-03', 0.50, '1', 'cancelled', NULL, NULL, NULL, '2026-08-03 15:40:06'),
(9, 12, NULL, '2026-08-17', 1.00, 'overtime', 'cancelled', NULL, NULL, NULL, '2026-08-17 16:23:30');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `id` int(10) UNSIGNED NOT NULL,
  `token` varchar(128) NOT NULL,
  `role` enum('admin','manager','cashier') NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `user_table` enum('admins','employees') NOT NULL,
  `expires_at` datetime NOT NULL,
  `otp_code` varchar(6) DEFAULT NULL,
  `otp_verified` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `password_reset_tokens`
--

INSERT INTO `password_reset_tokens` (`id`, `token`, `role`, `user_id`, `user_table`, `expires_at`, `otp_code`, `otp_verified`) VALUES
(24, '0dfe2679fb7baec80952213d256a663ae491430aff7ee986e940d7e07878b899', 'cashier', 12, 'employees', '2026-08-07 12:11:15', '955191', 0),
(25, 'e50bbe28b79c917b80811efb08222f723dcc5bcd47b4adb203eeee08303230fd', 'admin', 6, 'admins', '2026-08-07 12:12:09', '890806', 0),
(26, 'ccb78fbd94eb0bb50020dabfa4138a55de31e08b8b1731a04db88118f83453ea', 'cashier', 12, 'employees', '2026-08-07 12:12:24', '729622', 0),
(27, '45922b290efcc688ce11636df14ddd06b7d27487516d1e2977be6647e6e7d57e', 'cashier', 12, 'employees', '2026-08-07 12:21:03', '972175', 0),
(28, '8dc869ed079db9dc3be81b634391dd3a18d5422f16e78f7ff90e2dfb9741dc60', 'cashier', 12, 'employees', '2026-08-07 12:22:57', '371289', 0),
(29, 'f67e3477bbd464f94d995d1edaac3ba18517becdd4c9ea0971022e2d73c6233d', 'cashier', 12, 'employees', '2026-08-07 12:25:02', '161019', 0),
(30, 'd9d225625cdf6a5ef8d70c2e7b38f42fc65e15960796f947f25c971c0561d1e1', 'admin', 6, 'admins', '2026-08-07 12:25:48', '411160', 0),
(31, '86d84e412f93c5eeb6158d4175e43ac24d51db75159b8e53ec30800cad910bd1', 'cashier', 12, 'employees', '2026-08-07 12:29:20', '439920', 1),
(32, '94a0ab4079e2fd36c750e1fd641bc605e376b5c615279882d22029001fd18323', 'cashier', 12, 'employees', '2026-08-07 12:31:04', '845683', 1),
(34, '1ebd44079351818e5893449b8676ff940cb50ba2451f3aba82b3a14495072b7f', 'admin', 6, 'admins', '2026-08-07 12:36:10', '217476', 1);

-- --------------------------------------------------------

--
-- Table structure for table `payroll_periods`
--

CREATE TABLE `payroll_periods` (
  `payroll_id` int(10) UNSIGNED NOT NULL,
  `employee_id` int(11) NOT NULL,
  `period_start` date NOT NULL,
  `period_end` date NOT NULL,
  `total_hours` decimal(8,2) NOT NULL DEFAULT 0.00,
  `total_pay` decimal(12,2) NOT NULL DEFAULT 0.00,
  `days_worked` smallint(6) NOT NULL DEFAULT 0,
  `status` enum('draft','finalized') NOT NULL DEFAULT 'draft',
  `generated_at` datetime NOT NULL DEFAULT current_timestamp(),
  `finalized_at` datetime DEFAULT NULL,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payroll_periods`
--

INSERT INTO `payroll_periods` (`payroll_id`, `employee_id`, `period_start`, `period_end`, `total_hours`, `total_pay`, `days_worked`, `status`, `generated_at`, `finalized_at`, `notes`) VALUES
(4, 12, '2026-08-01', '2026-08-15', 0.00, 0.00, 0, 'draft', '2026-08-12 00:06:30', NULL, NULL),
(5, 12, '2026-08-06', '2026-08-20', 0.00, 0.00, 0, 'draft', '2026-08-07 14:23:21', NULL, NULL),
(16, 12, '2026-08-04', '2026-08-15', 0.00, 0.00, 0, 'draft', '2026-08-07 15:10:28', NULL, NULL),
(18, 12, '2026-08-05', '2026-08-20', 23.52, 905.59, 1, 'draft', '2026-08-21 22:04:54', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED DEFAULT NULL,
  `name` varchar(120) NOT NULL,
  `description` text DEFAULT NULL,
  `sku` varchar(60) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `cost` decimal(10,2) NOT NULL DEFAULT 0.00,
  `stock` int(11) NOT NULL DEFAULT 0,
  `reorder_point` int(11) NOT NULL DEFAULT 5,
  `unit` varchar(30) NOT NULL DEFAULT 'pcs',
  `icon` varchar(10) NOT NULL DEFAULT '?',
  `image_url` varchar(512) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `cup_eligible` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `category_id`, `name`, `description`, `sku`, `price`, `cost`, `stock`, `reorder_point`, `unit`, `icon`, `image_url`, `is_active`, `created_at`, `updated_at`, `cup_eligible`) VALUES
(79, 53, 'Spanish Latte', NULL, NULL, 111.00, 11.00, 0, 5, 'pcs', '?', '/static/product_images/prod_a88f410a5dcf08c31e7fa405.webp', 1, '2026-08-05 14:56:19', '2026-08-11 06:22:24', 1),
(95, 59, 'Chicken pop, Fries and Drnks', NULL, NULL, 55.00, 0.00, 0, 5, 'pcs', '?', NULL, 0, '2026-08-11 05:01:09', '2026-08-11 05:25:18', 1),
(96, 61, 'Bacon Roll with Rice', NULL, 'C6', 65.00, 0.00, 0, 5, 'pcs', '?', NULL, 1, '2026-08-11 05:11:15', '2026-08-11 05:11:15', 0),
(97, 61, 'Chicken Pop with Rice', NULL, 'C7', 65.00, 0.00, 0, 5, 'pcs', '?', '/static/product_images/prod_5281e082aef900d7e986446c.jpg', 1, '2026-08-11 05:16:14', '2026-08-11 06:28:02', 0),
(98, 61, 'Hotdog with Rice', NULL, 'C8', 55.00, 0.00, 0, 5, 'pcs', '?', '/static/product_images/prod_0d62391169404383d2a9b5fd.webp', 1, '2026-08-11 05:16:46', '2026-08-11 06:29:09', 0),
(99, 61, 'Siomai with Rice', NULL, 'C9', 55.00, 0.00, 0, 5, 'pcs', '?', '/static/product_images/prod_c552f3546074f6f63b89608f.jpg', 1, '2026-08-11 05:17:14', '2026-08-11 06:34:47', 0),
(100, 61, 'Shanghai with Rice', NULL, 'C10', 55.00, 0.00, 0, 5, 'pcs', '?', '/static/product_images/prod_3ea09ade6de17e81f6bbebf1.webp', 1, '2026-08-11 05:18:14', '2026-08-11 06:33:42', 0),
(101, 61, 'Nuggets with Rice', NULL, 'C11', 55.00, 0.00, 0, 5, 'pcs', '?', '/static/product_images/prod_a12b09a992fe375e203f37fc.webp', 1, '2026-08-11 05:18:48', '2026-08-11 06:32:40', 0),
(102, 60, 'Hotdog , Fries & Drinks', NULL, 'C1', 55.00, 0.00, 0, 5, 'pcs', '?', NULL, 1, '2026-08-11 05:20:07', '2026-08-11 05:20:22', 0),
(103, 60, 'Chicken Pop, Fries and Drinks', NULL, 'C2', 55.00, 0.00, 0, 5, 'pcs', '?', NULL, 1, '2026-08-11 05:21:03', '2026-08-11 05:21:03', 0),
(104, 60, 'Chicken Pop, Cheese sticks  & Drinks', NULL, 'C3', 55.00, 0.00, 0, 5, 'pcs', '?', NULL, 1, '2026-08-11 05:22:32', '2026-08-11 05:22:32', 0),
(105, 60, 'Cheese Stick, Hotdog, Fries & Drinks', NULL, 'C4', 55.00, 0.00, 0, 5, 'pcs', '?', NULL, 1, '2026-08-11 05:23:58', '2026-08-11 05:23:58', 0),
(106, 60, 'Chicken Pop, Hotdog, cheese Sticks & Drinks', NULL, 'C5', 75.00, 0.00, 0, 5, 'pcs', '?', NULL, 1, '2026-08-11 05:25:01', '2026-08-11 05:25:01', 0),
(107, 63, 'Fries', NULL, NULL, 25.00, 0.00, 0, 5, 'pcs', '?', '/static/product_images/prod_0d0725018a1ba306b6fcc0fa.webp', 1, '2026-08-11 05:26:58', '2026-08-11 06:17:45', 0),
(108, 63, 'Cheese Sticks (5 pcs)', NULL, NULL, 25.00, 0.00, 0, 5, 'pcs', '?', '/static/product_images/prod_57f05075623c7989ab0909a6.webp', 1, '2026-08-11 05:27:40', '2026-08-11 06:15:54', 0),
(109, 63, 'Hotdog on Stick', NULL, NULL, 25.00, 0.00, 0, 5, 'pcs', '?', '/static/product_images/prod_72a18e44bf2f3f65673099da.jpg', 1, '2026-08-11 05:28:06', '2026-08-11 06:16:56', 0),
(110, 63, 'Siomai (3 pcs)', NULL, NULL, 25.00, 0.00, 0, 5, 'pcs', '?', '/static/product_images/prod_6a5d1352765d67e351848476.jpg', 1, '2026-08-11 05:28:36', '2026-08-11 06:03:04', 0),
(111, 63, 'Nachos', NULL, NULL, 60.00, 0.00, 0, 5, 'pcs', '?', '/static/product_images/prod_30fdef61edd327975748d0e7.png', 1, '2026-08-11 05:29:00', '2026-08-11 06:13:02', 0),
(112, 63, 'Hashbrown', NULL, NULL, 55.00, 0.00, 0, 5, 'pcs', '?', '/static/product_images/prod_ee4df9ba465ad94585f28230.jpg', 1, '2026-08-11 05:29:24', '2026-08-11 06:09:55', 0),
(113, 63, 'Nuggets', NULL, NULL, 55.00, 0.00, 0, 5, 'pcs', '?', '/static/product_images/prod_e8d3db415e14b2e8da33c077.webp', 1, '2026-08-11 05:29:43', '2026-08-11 06:06:09', 0),
(114, 62, 'Banana muffin (3pcs)', NULL, NULL, 100.00, 0.00, 0, 5, 'pcs', '?', '/static/product_images/prod_ba5850a6d3481ab402055795.webp', 1, '2026-08-11 05:32:00', '2026-08-11 05:59:56', 0),
(115, 62, 'Brazos (Cupcakes)', NULL, NULL, 100.00, 0.00, 0, 5, 'pcs', '?', '/static/product_images/prod_cf3448fbb10ff5e54c23f07d.jpg', 1, '2026-08-11 05:32:37', '2026-08-11 06:14:38', 0),
(116, 62, 'Dulce de Leche (slice)', NULL, NULL, 95.00, 0.00, 0, 5, 'pcs', '?', '/static/product_images/prod_7163a3487563ae864a929a2b.jpg', 1, '2026-08-11 05:33:09', '2026-08-11 06:20:32', 0),
(117, 62, 'Yema cake (slice)', NULL, NULL, 95.00, 0.00, 0, 5, 'pcs', '?', '/static/product_images/prod_b821fba79cbd68992e962b44.webp', 1, '2026-08-11 05:33:34', '2026-08-11 06:21:23', 0),
(118, 59, 'Chicken Alfredo', NULL, NULL, 120.00, 0.00, 0, 5, 'pcs', '?', '/static/product_images/prod_c22e287845c0ba9458b8787c.jpg', 1, '2026-08-11 05:34:36', '2026-08-11 06:25:50', 0),
(119, 59, 'Carbonara', NULL, NULL, 120.00, 0.00, 0, 5, 'pcs', '?', '/static/product_images/prod_2f032ae5bd51f11e6d9836b6.jpg', 1, '2026-08-11 05:34:56', '2026-08-11 06:25:02', 0),
(120, 59, 'Fries & Nachos', NULL, NULL, 150.00, 0.00, 0, 5, 'pcs', '?', NULL, 1, '2026-08-11 05:35:23', '2026-08-11 05:35:23', 0),
(121, 59, 'Fries & Chicken Popcorn', NULL, NULL, 150.00, 0.00, 0, 5, 'pcs', '?', NULL, 1, '2026-08-11 05:35:55', '2026-08-11 05:35:55', 0),
(122, 59, 'Barkada Treats', NULL, NULL, 199.00, 0.00, 0, 5, 'pcs', '?', NULL, 1, '2026-08-11 05:36:21', '2026-08-11 05:36:21', 0);

-- --------------------------------------------------------

--
-- Table structure for table `shift_config`
--

CREATE TABLE `shift_config` (
  `id` int(11) NOT NULL,
  `label` varchar(100) NOT NULL,
  `start_time` varchar(5) NOT NULL,
  `end_time` varchar(5) NOT NULL,
  `color` varchar(20) NOT NULL DEFAULT '#c9a961',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shift_config`
--

INSERT INTO `shift_config` (`id`, `label`, `start_time`, `end_time`, `color`, `created_at`) VALUES
(1, '8AM', '08:00', '18:00', '#4caf50', '2026-05-19 14:12:12');

-- --------------------------------------------------------

--
-- Table structure for table `stock_requests`
--

CREATE TABLE `stock_requests` (
  `id` int(10) UNSIGNED NOT NULL,
  `item_name` varchar(120) NOT NULL,
  `item_type` enum('ingredient','packaging') NOT NULL DEFAULT 'ingredient',
  `quantity` decimal(12,2) NOT NULL DEFAULT 0.00,
  `unit` varchar(20) NOT NULL DEFAULT 'pcs',
  `note` varchar(255) DEFAULT NULL,
  `requested_by` varchar(80) NOT NULL,
  `requested_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `reviewed_by` varchar(80) DEFAULT NULL,
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `review_note` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stock_requests`
--

INSERT INTO `stock_requests` (`id`, `item_name`, `item_type`, `quantity`, `unit`, `note`, `requested_by`, `requested_at`, `status`, `reviewed_by`, `reviewed_at`, `review_note`) VALUES
(1, 'Milk', 'ingredient', 1.00, 'pcs', NULL, 'patrimonio', '2026-08-10 14:50:03', 'rejected', 'Admin', '2026-08-18 14:50:45', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `transaction_id` int(10) UNSIGNED NOT NULL,
  `cashier_id` int(11) NOT NULL,
  `cashier_name` varchar(255) NOT NULL DEFAULT '',
  `subtotal` decimal(12,2) NOT NULL DEFAULT 0.00,
  `discount_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `tax_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `total_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `amount_tendered` decimal(12,2) NOT NULL DEFAULT 0.00,
  `change_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `payment_method` enum('cash','card','gcash','maya','other') NOT NULL DEFAULT 'cash',
  `gcash_ref` varchar(50) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `status` enum('completed','voided') NOT NULL DEFAULT 'completed',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `discount_type` enum('none','senior','pwd','manual') NOT NULL DEFAULT 'none',
  `net_sales` decimal(12,2) NOT NULL DEFAULT 0.00,
  `vat_amount` decimal(12,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transaction_items`
--

CREATE TABLE `transaction_items` (
  `item_id` int(10) UNSIGNED NOT NULL,
  `transaction_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED DEFAULT NULL,
  `product_name` varchar(120) NOT NULL,
  `category_name` varchar(80) NOT NULL DEFAULT '',
  `unit_price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `line_total` decimal(12,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `app_settings`
--
ALTER TABLE `app_settings`
  ADD PRIMARY KEY (`setting_key`);

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`attendance_id`),
  ADD KEY `attendance_ibfk_1` (`employee_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `uq_category_name` (`name`);

--
-- Indexes for table `email_alert_settings`
--
ALTER TABLE `email_alert_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`employee_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `application_id` (`application_id`);

--
-- Indexes for table `employees_trash`
--
ALTER TABLE `employees_trash`
  ADD PRIMARY KEY (`trash_id`),
  ADD KEY `idx_delete_at` (`delete_at`),
  ADD KEY `idx_employee_id` (`employee_id`);

--
-- Indexes for table `employee_applications`
--
ALTER TABLE `employee_applications`
  ADD PRIMARY KEY (`application_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `face_mismatch_log`
--
ALTER TABLE `face_mismatch_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_employee_id` (`employee_id`),
  ADD KEY `idx_attempted_at` (`attempted_at`);

--
-- Indexes for table `inv_items`
--
ALTER TABLE `inv_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_type` (`type`),
  ADD KEY `idx_active` (`is_active`);

--
-- Indexes for table `inv_log`
--
ALTER TABLE `inv_log`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `idx_item` (`item_id`),
  ADD KEY `idx_created_at` (`created_at`),
  ADD KEY `idx_source` (`source`);

--
-- Indexes for table `login_attempts`
--
ALTER TABLE `login_attempts`
  ADD PRIMARY KEY (`attempt_key`);

--
-- Indexes for table `overtime_requests`
--
ALTER TABLE `overtime_requests`
  ADD PRIMARY KEY (`request_id`),
  ADD KEY `idx_ot_employee` (`employee_id`),
  ADD KEY `idx_ot_status` (`status`),
  ADD KEY `idx_ot_date` (`request_date`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token` (`token`),
  ADD KEY `idx_token` (`token`),
  ADD KEY `idx_expires_at` (`expires_at`);

--
-- Indexes for table `payroll_periods`
--
ALTER TABLE `payroll_periods`
  ADD PRIMARY KEY (`payroll_id`),
  ADD UNIQUE KEY `uq_emp_period` (`employee_id`,`period_start`),
  ADD KEY `idx_period_start` (`period_start`),
  ADD KEY `idx_employee_id` (`employee_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `idx_category` (`category_id`),
  ADD KEY `idx_active` (`is_active`);

--
-- Indexes for table `shift_config`
--
ALTER TABLE `shift_config`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stock_requests`
--
ALTER TABLE `stock_requests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`transaction_id`),
  ADD KEY `idx_cashier` (`cashier_id`),
  ADD KEY `idx_created_at` (`created_at`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `transaction_items`
--
ALTER TABLE `transaction_items`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `idx_tx` (`transaction_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `attendance_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `email_alert_settings`
--
ALTER TABLE `email_alert_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `employee_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `employees_trash`
--
ALTER TABLE `employees_trash`
  MODIFY `trash_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `employee_applications`
--
ALTER TABLE `employee_applications`
  MODIFY `application_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `face_mismatch_log`
--
ALTER TABLE `face_mismatch_log`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `inv_items`
--
ALTER TABLE `inv_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `inv_log`
--
ALTER TABLE `inv_log`
  MODIFY `log_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `overtime_requests`
--
ALTER TABLE `overtime_requests`
  MODIFY `request_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `payroll_periods`
--
ALTER TABLE `payroll_periods`
  MODIFY `payroll_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=123;

--
-- AUTO_INCREMENT for table `shift_config`
--
ALTER TABLE `shift_config`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `stock_requests`
--
ALTER TABLE `stock_requests`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `transaction_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `transaction_items`
--
ALTER TABLE `transaction_items`
  MODIFY `item_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE;

--
-- Constraints for table `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `employee_applications` (`application_id`) ON DELETE SET NULL;

--
-- Constraints for table `payroll_periods`
--
ALTER TABLE `payroll_periods`
  ADD CONSTRAINT `payroll_periods_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `fk_product_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE SET NULL;

--
-- Constraints for table `transaction_items`
--
ALTER TABLE `transaction_items`
  ADD CONSTRAINT `fk_ti_transaction` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`transaction_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
