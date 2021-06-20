/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.5.1"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* First part of user prologue.  */
#line 2 "part.ypp"

	#include <stdlib.h>
	#include <stdio.h>
	#include <iostream>
	#include <string>
	#include "sysy_node.hpp"
	#include <map>

	using namespace std;

	extern int yylex();
	void yyerror(char const *message);
	void IdentDeclareCheck(GrammaNode* deIdent);
	GrammaNode* IdentDefineCheck(GrammaNode* deIdent);
	int scopeCmp(string presScope, string varScope);
	void scopePush();
	void scopePop();

	//外部的lineno，行号信息
	extern int lineno;

	// multimap <标识符名称， 作用域> 变量名列表
	extern multimap<string, string> idNameList;
	// map <<标识符名称， 作用域>, 结点指针> 变量列表
	extern map<pair<string, string>, GrammaNode*> idList;
	
	unsigned int top = 0;
	string presentScope = "1";
	unsigned char max_scope_id = SCOPT_ID_BASE; //'1'

#line 101 "part.tab.cpp"

# ifndef YY_CAST
#  ifdef __cplusplus
#   define YY_CAST(Type, Val) static_cast<Type> (Val)
#   define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type> (Val)
#  else
#   define YY_CAST(Type, Val) ((Type) (Val))
#   define YY_REINTERPRET_CAST(Type, Val) ((Type) (Val))
#  endif
# endif
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* Use api.header.include to #include this header
   instead of duplicating it here.  */
#ifndef YY_YY_PART_TAB_HPP_INCLUDED
# define YY_YY_PART_TAB_HPP_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    ASSIGN = 258,
    SEMI = 259,
    COMM = 260,
    RDBRAL = 261,
    RDBRAR = 262,
    SQBRAL = 263,
    SQBRAR = 264,
    BRAL = 265,
    BRAR = 266,
    ADD = 267,
    SUB = 268,
    DIV = 269,
    MUL = 270,
    MOD = 271,
    EQ = 272,
    NOT = 273,
    NEQ = 274,
    OR = 275,
    AND = 276,
    LT = 277,
    BG = 278,
    LQ = 279,
    BQ = 280,
    ZERO = 281,
    INT = 282,
    CONST = 283,
    IntConst_D = 284,
    IntConst_O = 285,
    IntConst_H = 286,
    VOID = 287,
    IF = 288,
    ELSE = 289,
    WHILE = 290,
    BREAK = 291,
    CONTINUE = 292,
    RETURN = 293,
    MAIN = 294,
    Ident = 295
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 33 "part.ypp"

        struct GrammaNode *no;

#line 198 "part.tab.cpp"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_PART_TAB_HPP_INCLUDED  */



#ifdef short
# undef short
#endif

/* On compilers that do not define __PTRDIFF_MAX__ etc., make sure
   <limits.h> and (if available) <stdint.h> are included
   so that the code can choose integer types of a good width.  */

#ifndef __PTRDIFF_MAX__
# include <limits.h> /* INFRINGES ON USER NAME SPACE */
# if defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stdint.h> /* INFRINGES ON USER NAME SPACE */
#  define YY_STDINT_H
# endif
#endif

/* Narrow types that promote to a signed type and that can represent a
   signed or unsigned integer of at least N bits.  In tables they can
   save space and decrease cache pressure.  Promoting to a signed type
   helps avoid bugs in integer arithmetic.  */

#ifdef __INT_LEAST8_MAX__
typedef __INT_LEAST8_TYPE__ yytype_int8;
#elif defined YY_STDINT_H
typedef int_least8_t yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef __INT_LEAST16_MAX__
typedef __INT_LEAST16_TYPE__ yytype_int16;
#elif defined YY_STDINT_H
typedef int_least16_t yytype_int16;
#else
typedef short yytype_int16;
#endif

#if defined __UINT_LEAST8_MAX__ && __UINT_LEAST8_MAX__ <= __INT_MAX__
typedef __UINT_LEAST8_TYPE__ yytype_uint8;
#elif (!defined __UINT_LEAST8_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST8_MAX <= INT_MAX)
typedef uint_least8_t yytype_uint8;
#elif !defined __UINT_LEAST8_MAX__ && UCHAR_MAX <= INT_MAX
typedef unsigned char yytype_uint8;
#else
typedef short yytype_uint8;
#endif

#if defined __UINT_LEAST16_MAX__ && __UINT_LEAST16_MAX__ <= __INT_MAX__
typedef __UINT_LEAST16_TYPE__ yytype_uint16;
#elif (!defined __UINT_LEAST16_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST16_MAX <= INT_MAX)
typedef uint_least16_t yytype_uint16;
#elif !defined __UINT_LEAST16_MAX__ && USHRT_MAX <= INT_MAX
typedef unsigned short yytype_uint16;
#else
typedef int yytype_uint16;
#endif

#ifndef YYPTRDIFF_T
# if defined __PTRDIFF_TYPE__ && defined __PTRDIFF_MAX__
#  define YYPTRDIFF_T __PTRDIFF_TYPE__
#  define YYPTRDIFF_MAXIMUM __PTRDIFF_MAX__
# elif defined PTRDIFF_MAX
#  ifndef ptrdiff_t
#   include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  endif
#  define YYPTRDIFF_T ptrdiff_t
#  define YYPTRDIFF_MAXIMUM PTRDIFF_MAX
# else
#  define YYPTRDIFF_T long
#  define YYPTRDIFF_MAXIMUM LONG_MAX
# endif
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned
# endif
#endif

#define YYSIZE_MAXIMUM                                  \
  YY_CAST (YYPTRDIFF_T,                                 \
           (YYPTRDIFF_MAXIMUM < YY_CAST (YYSIZE_T, -1)  \
            ? YYPTRDIFF_MAXIMUM                         \
            : YY_CAST (YYSIZE_T, -1)))

#define YYSIZEOF(X) YY_CAST (YYPTRDIFF_T, sizeof (X))

/* Stored state numbers (used for stacks). */
typedef yytype_uint8 yy_state_t;

/* State numbers in computations.  */
typedef int yy_state_fast_t;

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_PURE __attribute__ ((__pure__))
# else
#  define YY_ATTRIBUTE_PURE
# endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_UNUSED __attribute__ ((__unused__))
# else
#  define YY_ATTRIBUTE_UNUSED
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && ! defined __ICC && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                            \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END      \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

#if defined __cplusplus && defined __GNUC__ && ! defined __ICC && 6 <= __GNUC__
# define YY_IGNORE_USELESS_CAST_BEGIN                          \
    _Pragma ("GCC diagnostic push")                            \
    _Pragma ("GCC diagnostic ignored \"-Wuseless-cast\"")
# define YY_IGNORE_USELESS_CAST_END            \
    _Pragma ("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_END
#endif


#define YY_ASSERT(E) ((void) (0 && (E)))

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yy_state_t yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (YYSIZEOF (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (YYSIZEOF (yy_state_t) + YYSIZEOF (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYPTRDIFF_T yynewbytes;                                         \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * YYSIZEOF (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / YYSIZEOF (*yyptr);                        \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, YY_CAST (YYSIZE_T, (Count)) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYPTRDIFF_T yyi;                      \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  16
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   277

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  41
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  37
/* YYNRULES -- Number of rules.  */
#define YYNRULES  96
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  177

#define YYUNDEFTOK  2
#define YYMAXUTOK   295


/* YYTRANSLATE(TOKEN-NUM) -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, with out-of-bounds checking.  */
#define YYTRANSLATE(YYX)                                                \
  (0 <= (YYX) && (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex.  */
static const yytype_int8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_int16 yyrline[] =
{
       0,    59,    59,    60,    61,    62,    67,    68,    76,    80,
      81,    87,    92,   101,   105,   106,   111,   116,   121,   126,
     134,   135,   136,   140,   141,   146,   152,   158,   164,   172,
     179,   186,   191,   198,   203,   208,   218,   222,   227,   231,
     236,   243,   244,   249,   250,   251,   252,   253,   259,   266,
     272,   273,   274,   275,   279,   284,   285,   290,   296,   301,
     309,   310,   315,   316,   317,   324,   325,   330,   335,   340,
     341,   342,   352,   353,   358,   359,   360,   361,   366,   367,
     368,   372,   373,   374,   375,   376,   380,   381,   382,   386,
     387,   391,   392,   398,   399,   400,   401
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 0
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "ASSIGN", "SEMI", "COMM", "RDBRAL",
  "RDBRAR", "SQBRAL", "SQBRAR", "BRAL", "BRAR", "ADD", "SUB", "DIV", "MUL",
  "MOD", "EQ", "NOT", "NEQ", "OR", "AND", "LT", "BG", "LQ", "BQ", "ZERO",
  "INT", "CONST", "IntConst_D", "IntConst_O", "IntConst_H", "VOID", "IF",
  "ELSE", "WHILE", "BREAK", "CONTINUE", "RETURN", "MAIN", "Ident",
  "$accept", "CompUnit", "Decl", "ConstDecl", "ConstDefs", "ConstDef",
  "VarDecl", "VarDefs", "VarDef", "InitVal", "InitVals", "FuncDef",
  "Ident_TEMP", "RDBRAL_TEMP", "FuncFParams", "FuncFParam", "BlockItems",
  "Block", "BARL_TEMP", "BlockItem", "Stmt", "Cond", "ConstExps", "Exp",
  "LVal", "Exps", "PrimaryExp", "UnaryExp", "UnaryOp", "FuncRParams",
  "MulExp", "AddExp", "RelExp", "EqExp", "LAndExp", "LOrExp", "IntConst", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_int16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295
};
# endif

#define YYPACT_NINF (-145)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-30)

#define yytable_value_is_error(Yyn) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int16 yypact[] =
{
      -6,   -17,     5,    36,     6,  -145,  -145,  -145,  -145,    87,
      50,  -145,    80,    61,  -145,    80,  -145,  -145,  -145,    54,
     225,  -145,    64,  -145,    -3,    10,    58,  -145,    13,   225,
      39,  -145,  -145,  -145,  -145,  -145,  -145,  -145,    67,  -145,
    -145,  -145,  -145,  -145,   225,    82,    97,  -145,   107,  -145,
      45,  -145,   116,    96,    95,  -145,    54,   225,  -145,    61,
     116,   100,   134,  -145,  -145,     3,   210,   225,   137,  -145,
     225,   225,   225,   225,   225,    53,   136,  -145,   140,   143,
     127,   116,  -145,   147,  -145,  -145,   116,  -145,    54,  -145,
    -145,  -145,   112,   148,   225,  -145,  -145,  -145,    82,    82,
      54,   225,  -145,  -145,    64,   155,   156,   159,   160,    -1,
    -145,   102,  -145,  -145,  -145,   161,   169,   165,  -145,  -145,
      74,  -145,  -145,   225,  -145,  -145,   173,  -145,  -145,   225,
     225,  -145,  -145,  -145,   179,  -145,  -145,  -145,   225,   176,
      54,  -145,  -145,   182,    97,    99,   108,   170,   166,   183,
    -145,   188,   137,  -145,   175,   225,   225,   225,   225,   225,
     225,   225,   225,   175,  -145,   162,    97,    97,    97,    97,
      99,    99,   108,   170,  -145,   175,  -145
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_int8 yydefact[] =
{
       0,     0,     0,     0,     0,     2,     6,     7,     3,    18,
       0,    14,     0,     0,    29,     0,     1,     4,     5,     0,
       0,    13,     0,    30,     0,     0,     0,     9,     0,     0,
       0,    69,    70,    71,    96,    93,    94,    95,    59,    19,
      20,    63,    65,    74,     0,    78,    57,    64,     0,    55,
      18,    15,     0,     0,     0,    31,     0,     0,     8,     0,
       0,     0,     0,    21,    23,     0,     0,     0,    58,    68,
       0,     0,     0,     0,     0,    17,    40,    25,     0,    33,
       0,     0,    12,     0,    10,    26,     0,    62,     0,    22,
      66,    72,     0,     0,     0,    76,    75,    77,    79,    80,
       0,     0,    39,    44,     0,     0,     0,     0,     0,     0,
      41,     0,    46,    36,    42,     0,    63,     0,    32,    27,
       0,    28,    24,     0,    67,    60,     0,    16,    56,     0,
       0,    50,    51,    52,     0,    38,    37,    45,     0,    35,
       0,    73,    61,     0,    81,    86,    89,    91,    54,     0,
      53,     0,    34,    11,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,    43,    47,    82,    83,    84,    85,
      87,    88,    90,    92,    49,     0,    48
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -145,  -145,    88,  -145,  -145,   135,  -145,  -145,   177,   -29,
    -145,   191,   194,   185,   174,   118,  -145,   -45,  -145,    92,
    -144,    77,   152,   -20,   -76,    79,  -145,   -28,  -145,  -145,
      75,   115,     0,    59,    52,  -145,  -145
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,     4,   110,     6,    26,    27,     7,    10,    11,    39,
      65,     8,    12,    24,    54,    55,   111,   112,    78,   113,
     114,   143,    48,    40,    41,    68,    42,    43,    44,    92,
      45,    46,   145,   146,   147,   148,    47
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int16 yytable[] =
{
      49,    64,   116,   133,    52,    29,    16,    77,    88,    62,
     165,    31,    32,    56,    89,    85,    69,    33,    57,   174,
      60,     1,     2,     9,    53,    34,     3,    82,    35,    36,
      37,   176,    13,     1,     2,   116,   119,    49,     3,    38,
      53,   121,    95,    96,    97,    29,    91,    93,    19,    30,
      63,    31,    32,    20,    21,    22,   100,    33,   115,   122,
      29,   101,    58,    59,    30,    34,    31,    32,    35,    36,
      37,   127,    33,    66,   126,    67,    14,   140,   116,    38,
      34,   128,   101,    35,    36,    37,    23,   116,     5,   134,
      19,   115,    17,   -29,    38,    20,    70,    71,    72,   116,
      80,    25,    81,   141,    50,    80,   103,    86,    29,    73,
      74,   153,    76,   135,    31,    32,    75,   123,   151,   124,
      33,   155,   156,   157,   158,   159,    76,   160,    34,   104,
       2,    35,    36,    37,   115,   105,    79,   106,   107,   108,
     109,    87,    38,   115,   103,    94,    29,   102,    98,    99,
      76,   117,    31,    32,    53,   115,   120,   125,    33,   170,
     171,   129,   130,   131,   132,   137,    34,   104,     2,    35,
      36,    37,   138,   105,   139,   106,   107,   108,   109,   103,
      38,    29,   142,   150,    67,    76,   162,    31,    32,   154,
     163,   161,   164,    33,    84,    18,   175,    15,   118,    51,
      28,    34,    61,   136,    35,    36,    37,   149,   105,    83,
     106,   107,   108,   109,   173,    38,    29,    90,   152,     0,
     172,     0,    31,    32,     0,     0,     0,     0,    33,     0,
       0,    29,     0,     0,     0,     0,    34,    31,    32,    35,
      36,    37,     0,    33,   144,   144,     0,     0,     0,     0,
      38,    34,     0,     0,    35,    36,    37,     0,     0,     0,
       0,     0,     0,     0,     0,    38,     0,     0,     0,     0,
     166,   167,   168,   169,   144,   144,   144,   144
};

static const yytype_int16 yycheck[] =
{
      20,    30,    78,     4,     7,     6,     0,    52,     5,    29,
     154,    12,    13,     3,    11,    60,    44,    18,     8,   163,
       7,    27,    28,    40,    27,    26,    32,    56,    29,    30,
      31,   175,    27,    27,    28,   111,    81,    57,    32,    40,
      27,    86,    70,    71,    72,     6,    66,    67,     3,    10,
      11,    12,    13,     8,     4,     5,     3,    18,    78,    88,
       6,     8,     4,     5,    10,    26,    12,    13,    29,    30,
      31,   100,    18,     6,    94,     8,    40,     3,   154,    40,
      26,   101,     8,    29,    30,    31,     6,   163,     0,   109,
       3,   111,     4,     6,    40,     8,    14,    15,    16,   175,
       5,    40,     7,   123,    40,     5,     4,     7,     6,    12,
      13,   140,    10,    11,    12,    13,     9,     5,   138,     7,
      18,    22,    23,    24,    25,    17,    10,    19,    26,    27,
      28,    29,    30,    31,   154,    33,    40,    35,    36,    37,
      38,     7,    40,   163,     4,     8,     6,    11,    73,    74,
      10,     8,    12,    13,    27,   175,     9,     9,    18,   159,
     160,     6,     6,     4,     4,     4,    26,    27,    28,    29,
      30,    31,     3,    33,     9,    35,    36,    37,    38,     4,
      40,     6,     9,     4,     8,    10,    20,    12,    13,     7,
       7,    21,     4,    18,    59,     4,    34,     3,    80,    22,
      15,    26,    28,   111,    29,    30,    31,   130,    33,    57,
      35,    36,    37,    38,   162,    40,     6,     7,   139,    -1,
     161,    -1,    12,    13,    -1,    -1,    -1,    -1,    18,    -1,
      -1,     6,    -1,    -1,    -1,    -1,    26,    12,    13,    29,
      30,    31,    -1,    18,   129,   130,    -1,    -1,    -1,    -1,
      40,    26,    -1,    -1,    29,    30,    31,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    40,    -1,    -1,    -1,    -1,
     155,   156,   157,   158,   159,   160,   161,   162
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_int8 yystos[] =
{
       0,    27,    28,    32,    42,    43,    44,    47,    52,    40,
      48,    49,    53,    27,    40,    53,     0,    43,    52,     3,
       8,     4,     5,     6,    54,    40,    45,    46,    54,     6,
      10,    12,    13,    18,    26,    29,    30,    31,    40,    50,
      64,    65,    67,    68,    69,    71,    72,    77,    63,    64,
      40,    49,     7,    27,    55,    56,     3,     8,     4,     5,
       7,    55,    64,    11,    50,    51,     6,     8,    66,    68,
      14,    15,    16,    12,    13,     9,    10,    58,    59,    40,
       5,     7,    50,    63,    46,    58,     7,     7,     5,    11,
       7,    64,    70,    64,     8,    68,    68,    68,    71,    71,
       3,     8,    11,     4,    27,    33,    35,    36,    37,    38,
      43,    57,    58,    60,    61,    64,    65,     8,    56,    58,
       9,    58,    50,     5,     7,     9,    64,    50,    64,     6,
       6,     4,     4,     4,    64,    11,    60,     4,     3,     9,
       3,    64,     9,    62,    72,    73,    74,    75,    76,    62,
       4,    64,    66,    50,     7,    22,    23,    24,    25,    17,
      19,    21,    20,     7,     4,    61,    72,    72,    72,    72,
      73,    73,    74,    75,    61,    34,    61
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_int8 yyr1[] =
{
       0,    41,    42,    42,    42,    42,    43,    43,    44,    45,
      45,    46,    46,    47,    48,    48,    49,    49,    49,    49,
      50,    50,    50,    51,    51,    52,    52,    52,    52,    53,
      54,    55,    55,    56,    56,    56,    57,    57,    58,    58,
      59,    60,    60,    61,    61,    61,    61,    61,    61,    61,
      61,    61,    61,    61,    62,    63,    63,    64,    65,    65,
      66,    66,    67,    67,    67,    68,    68,    68,    68,    69,
      69,    69,    70,    70,    71,    71,    71,    71,    72,    72,
      72,    73,    73,    73,    73,    73,    74,    74,    74,    75,
      75,    76,    76,    77,    77,    77,    77
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     1,     1,     2,     2,     1,     1,     4,     1,
       3,     6,     3,     3,     1,     3,     6,     4,     1,     3,
       1,     2,     3,     1,     3,     5,     5,     6,     6,     1,
       1,     1,     3,     2,     5,     4,     1,     2,     3,     2,
       1,     1,     1,     4,     1,     2,     1,     5,     7,     5,
       2,     2,     2,     3,     1,     1,     4,     1,     2,     1,
       3,     4,     3,     1,     1,     1,     3,     4,     2,     1,
       1,     1,     1,     3,     1,     3,     3,     3,     1,     3,
       3,     1,     3,     3,     3,     3,     1,     3,     3,     1,
       3,     1,     3,     1,     1,     1,     1
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                    \
  do                                                              \
    if (yychar == YYEMPTY)                                        \
      {                                                           \
        yychar = (Token);                                         \
        yylval = (Value);                                         \
        YYPOPSTACK (yylen);                                       \
        yystate = *yyssp;                                         \
        goto yybackup;                                            \
      }                                                           \
    else                                                          \
      {                                                           \
        yyerror (YY_("syntax error: cannot back up")); \
        YYERROR;                                                  \
      }                                                           \
  while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256



/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo, int yytype, YYSTYPE const * const yyvaluep)
{
  FILE *yyoutput = yyo;
  YYUSE (yyoutput);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyo, yytoknum[yytype], *yyvaluep);
# endif
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo, int yytype, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyo, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  yy_symbol_value_print (yyo, yytype, yyvaluep);
  YYFPRINTF (yyo, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yy_state_t *yybottom, yy_state_t *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yy_state_t *yyssp, YYSTYPE *yyvsp, int yyrule)
{
  int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %d):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[+yyssp[yyi + 1 - yynrhs]],
                       &yyvsp[(yyi + 1) - (yynrhs)]
                                              );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen(S) (YY_CAST (YYPTRDIFF_T, strlen (S)))
#  else
/* Return the length of YYSTR.  */
static YYPTRDIFF_T
yystrlen (const char *yystr)
{
  YYPTRDIFF_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYPTRDIFF_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYPTRDIFF_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            else
              goto append;

          append:
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (yyres)
    return yystpcpy (yyres, yystr) - yyres;
  else
    return yystrlen (yystr);
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYPTRDIFF_T *yymsg_alloc, char **yymsg,
                yy_state_t *yyssp, int yytoken)
{
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat: reported tokens (one for the "unexpected",
     one per "expected"). */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Actual size of YYARG. */
  int yycount = 0;
  /* Cumulated lengths of YYARG.  */
  YYPTRDIFF_T yysize = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[+*yyssp];
      YYPTRDIFF_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
      yysize = yysize0;
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYPTRDIFF_T yysize1
                    = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
                    yysize = yysize1;
                  else
                    return 2;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
    default: /* Avoid compiler warnings. */
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    /* Don't count the "%s"s in the final size, but reserve room for
       the terminator.  */
    YYPTRDIFF_T yysize1 = yysize + (yystrlen (yyformat) - 2 * yycount) + 1;
    if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
      yysize = yysize1;
    else
      return 2;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          ++yyp;
          ++yyformat;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
{
  YYUSE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    yy_state_fast_t yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yy_state_t yyssa[YYINITDEPTH];
    yy_state_t *yyss;
    yy_state_t *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYPTRDIFF_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYPTRDIFF_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;


/*------------------------------------------------------------.
| yynewstate -- push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;


/*--------------------------------------------------------------------.
| yysetstate -- set current state (the top of the stack) to yystate.  |
`--------------------------------------------------------------------*/
yysetstate:
  YYDPRINTF ((stderr, "Entering state %d\n", yystate));
  YY_ASSERT (0 <= yystate && yystate < YYNSTATES);
  YY_IGNORE_USELESS_CAST_BEGIN
  *yyssp = YY_CAST (yy_state_t, yystate);
  YY_IGNORE_USELESS_CAST_END

  if (yyss + yystacksize - 1 <= yyssp)
#if !defined yyoverflow && !defined YYSTACK_RELOCATE
    goto yyexhaustedlab;
#else
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYPTRDIFF_T yysize = yyssp - yyss + 1;

# if defined yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        yy_state_t *yyss1 = yyss;
        YYSTYPE *yyvs1 = yyvs;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * YYSIZEOF (*yyssp),
                    &yyvs1, yysize * YYSIZEOF (*yyvsp),
                    &yystacksize);
        yyss = yyss1;
        yyvs = yyvs1;
      }
# else /* defined YYSTACK_RELOCATE */
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yy_state_t *yyss1 = yyss;
        union yyalloc *yyptr =
          YY_CAST (union yyalloc *,
                   YYSTACK_ALLOC (YY_CAST (YYSIZE_T, YYSTACK_BYTES (yystacksize))));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
# undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YY_IGNORE_USELESS_CAST_BEGIN
      YYDPRINTF ((stderr, "Stack size increased to %ld\n",
                  YY_CAST (long, yystacksize)));
      YY_IGNORE_USELESS_CAST_END

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }
#endif /* !defined yyoverflow && !defined YYSTACK_RELOCATE */

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;


/*-----------.
| yybackup.  |
`-----------*/
yybackup:
  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  /* Discard the shifted token.  */
  yychar = YYEMPTY;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
  case 2:
#line 59 "part.ypp"
                                        {Droot->son.push_back((yyvsp[0].no));}
#line 1515 "part.tab.cpp"
    break;

  case 3:
#line 60 "part.ypp"
                                        {Droot->son.push_back((yyvsp[0].no));}
#line 1521 "part.tab.cpp"
    break;

  case 4:
#line 61 "part.ypp"
                                {Droot->son.push_back((yyvsp[0].no));}
#line 1527 "part.tab.cpp"
    break;

  case 5:
#line 62 "part.ypp"
                                {Droot->son.push_back((yyvsp[0].no));}
#line 1533 "part.tab.cpp"
    break;

  case 6:
#line 67 "part.ypp"
              {(yyval.no)=(yyvsp[0].no);}
#line 1539 "part.tab.cpp"
    break;

  case 7:
#line 68 "part.ypp"
                  {(yyval.no)=(yyvsp[0].no);}
#line 1545 "part.tab.cpp"
    break;

  case 8:
#line 76 "part.ypp"
                                 {(yyval.no)=(yyvsp[-1].no);}
#line 1551 "part.tab.cpp"
    break;

  case 9:
#line 80 "part.ypp"
                                                        {(yyval.no)=new GrammaNode(lineno, ConstDefs_,"ConstDefs_");(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1557 "part.tab.cpp"
    break;

  case 10:
#line 81 "part.ypp"
                                        {(yyvsp[-2].no)->son.push_back((yyvsp[0].no));}
#line 1563 "part.tab.cpp"
    break;

  case 11:
#line 87 "part.ypp"
                                                     {
		(yyval.no) = new GrammaNode(lineno, ConstDef_array_,"ConstDef_array_");
		(yyval.no)->son.push_back((yyvsp[-5].no));(yyval.no)->son.push_back((yyvsp[-3].no));(yyval.no)->son.push_back((yyvsp[0].no));
		IdentDeclareCheck((yyvsp[-5].no));
	}
#line 1573 "part.tab.cpp"
    break;

  case 12:
#line 92 "part.ypp"
                              {
		(yyval.no) = new GrammaNode(lineno, ConstDef_single_,"ConstDef_single_");
		(yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[0].no));
		IdentDeclareCheck((yyvsp[-2].no));
	}
#line 1583 "part.tab.cpp"
    break;

  case 13:
#line 101 "part.ypp"
                                                        {(yyval.no)=(yyvsp[-1].no);}
#line 1589 "part.tab.cpp"
    break;

  case 14:
#line 105 "part.ypp"
                                                                {(yyval.no) = new GrammaNode(lineno, VarDefs_,"VarDefs"); (yyval.no)->son.push_back((yyvsp[0].no));}
#line 1595 "part.tab.cpp"
    break;

  case 15:
#line 106 "part.ypp"
                                                {(yyvsp[-2].no)->son.push_back((yyvsp[0].no));}
#line 1601 "part.tab.cpp"
    break;

  case 16:
#line 111 "part.ypp"
                                                     {
		(yyval.no) = new GrammaNode(lineno, VarDef_array_init_,"VarDef_array_init_");
		(yyval.no)->son.push_back((yyvsp[-5].no));(yyval.no)->son.push_back((yyvsp[-3].no));(yyval.no)->son.push_back((yyvsp[0].no));
		IdentDeclareCheck((yyvsp[-5].no));
	}
#line 1611 "part.tab.cpp"
    break;

  case 17:
#line 116 "part.ypp"
                                       {
		(yyval.no) = new GrammaNode(lineno, VarDef_array_,"VarDef_array_");
		(yyval.no)->son.push_back((yyvsp[-3].no));(yyval.no)->son.push_back((yyvsp[-1].no));
		IdentDeclareCheck((yyvsp[-3].no));
	}
#line 1621 "part.tab.cpp"
    break;

  case 18:
#line 121 "part.ypp"
               {
		(yyval.no) = new GrammaNode(lineno, VarDef_single_,"VarDef_single_");
		(yyval.no)->son.push_back((yyvsp[0].no));
		IdentDeclareCheck((yyvsp[0].no));
	}
#line 1631 "part.tab.cpp"
    break;

  case 19:
#line 126 "part.ypp"
                              {
		(yyval.no) = new GrammaNode(lineno, VarDef_single_init_,"VarDef_single_init_");
		(yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));
		IdentDeclareCheck((yyvsp[-2].no));
	}
#line 1641 "part.tab.cpp"
    break;

  case 20:
#line 134 "part.ypp"
                                                                        {(yyval.no) = new GrammaNode(lineno, InitVal_EXP,"InitVal_EXP"); (yyval.no)->son.push_back((yyvsp[0].no));}
#line 1647 "part.tab.cpp"
    break;

  case 21:
#line 135 "part.ypp"
                                                                {(yyval.no) = new GrammaNode(lineno, InitVal_NULL,"InitVal_NULL");}
#line 1653 "part.tab.cpp"
    break;

  case 22:
#line 136 "part.ypp"
                                                        {(yyval.no) = new GrammaNode(lineno, InitVal_,"InitVal"); (yyval.no)->son.push_back((yyvsp[-1].no));}
#line 1659 "part.tab.cpp"
    break;

  case 23:
#line 140 "part.ypp"
                                                                {(yyval.no) = new GrammaNode(lineno, InitVals_,"InitVals"); (yyval.no)->son.push_back((yyvsp[0].no));}
#line 1665 "part.tab.cpp"
    break;

  case 24:
#line 141 "part.ypp"
                                                {(yyvsp[-2].no)->son.push_back((yyvsp[0].no));}
#line 1671 "part.tab.cpp"
    break;

  case 25:
#line 146 "part.ypp"
                                                {
		(yyval.no) = new GrammaNode(lineno, FuncDef_int_,"FuncDef_int_");
		(yyval.no)->son.push_back((yyvsp[-3].no));(yyval.no)->son.push_back((yyvsp[0].no));
		// IdentDeclareCheck($2);
		scopePop();
	}
#line 1682 "part.tab.cpp"
    break;

  case 26:
#line 152 "part.ypp"
                                                        {
		(yyval.no) = new GrammaNode(lineno, FuncDef_void_,"FuncDef_void_");
		(yyval.no)->son.push_back((yyvsp[-3].no));(yyval.no)->son.push_back((yyvsp[0].no));
		// IdentDeclareCheck($2);
		scopePop();
	}
#line 1693 "part.tab.cpp"
    break;

  case 27:
#line 158 "part.ypp"
                                                             {
		(yyval.no) = new GrammaNode(lineno, FuncDef_int_para_,"FuncDef_int_para_");
		(yyval.no)->son.push_back((yyvsp[-4].no));(yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[0].no));
		// IdentDeclareCheck($2);
		scopePop();
	}
#line 1704 "part.tab.cpp"
    break;

  case 28:
#line 164 "part.ypp"
                                                              {
		(yyval.no) = new GrammaNode(lineno, FuncDef_void_para_,"FuncDef_void_para_");
		(yyval.no)->son.push_back((yyvsp[-4].no));(yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[0].no));
		// IdentDeclareCheck($2);
		scopePop();
	}
#line 1715 "part.tab.cpp"
    break;

  case 29:
#line 172 "part.ypp"
             {
		IdentDeclareCheck((yyvsp[0].no));
		(yyval.no) = (yyvsp[0].no);
	}
#line 1724 "part.tab.cpp"
    break;

  case 30:
#line 179 "part.ypp"
              {
		scopePush();
		(yyval.no) = (yyvsp[0].no);
	}
#line 1733 "part.tab.cpp"
    break;

  case 31:
#line 186 "part.ypp"
                   {
		// scopePush();
		(yyval.no) = new GrammaNode(lineno, FuncFParams_,"FuncFParams");
		(yyval.no)->son.push_back((yyvsp[0].no));
	}
#line 1743 "part.tab.cpp"
    break;

  case 32:
#line 191 "part.ypp"
                                     {
		(yyvsp[-2].no)->son.push_back((yyvsp[0].no));
	}
#line 1751 "part.tab.cpp"
    break;

  case 33:
#line 198 "part.ypp"
                  {
		(yyval.no) = new GrammaNode(lineno, FuncFParam_single_,"FuncFParam_single_");
		(yyval.no)->son.push_back((yyvsp[0].no));
		IdentDeclareCheck((yyvsp[0].no));
	}
#line 1761 "part.tab.cpp"
    break;

  case 34:
#line 203 "part.ypp"
                                      {
		(yyval.no) = new GrammaNode(lineno, FuncFParam_array_,"FuncFParam_array_");
		(yyval.no)->son.push_back((yyvsp[-3].no));(yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));
		IdentDeclareCheck((yyvsp[-3].no));
	}
#line 1771 "part.tab.cpp"
    break;

  case 35:
#line 208 "part.ypp"
                                 {
		(yyval.no) = new GrammaNode(lineno, FuncFParam_singleArray_,"FuncFParam_singleArray_");
		(yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));
		IdentDeclareCheck((yyvsp[-2].no));
	}
#line 1781 "part.tab.cpp"
    break;

  case 36:
#line 218 "part.ypp"
                  {
		(yyval.no) = new GrammaNode(lineno, Block_,"Block");
		(yyval.no)->son.push_back((yyvsp[0].no));
	}
#line 1790 "part.tab.cpp"
    break;

  case 37:
#line 222 "part.ypp"
                                                        {(yyvsp[-1].no)->son.push_back((yyvsp[0].no));}
#line 1796 "part.tab.cpp"
    break;

  case 38:
#line 227 "part.ypp"
                                  {
		(yyval.no)=(yyvsp[-1].no);
		scopePop();
	}
#line 1805 "part.tab.cpp"
    break;

  case 39:
#line 231 "part.ypp"
                   {}
#line 1811 "part.tab.cpp"
    break;

  case 40:
#line 236 "part.ypp"
            {
		scopePush();
		(yyval.no) = (yyvsp[0].no);
	}
#line 1820 "part.tab.cpp"
    break;

  case 41:
#line 243 "part.ypp"
                                                                        {(yyval.no)=(yyvsp[0].no);}
#line 1826 "part.tab.cpp"
    break;

  case 42:
#line 244 "part.ypp"
                                                                        {(yyval.no)=(yyvsp[0].no);}
#line 1832 "part.tab.cpp"
    break;

  case 43:
#line 249 "part.ypp"
                                                        {(yyval.no) = new GrammaNode(lineno, Stmt_Assign_,"Stmt_Assign"); (yyval.no)->son.push_back((yyvsp[-3].no));(yyval.no)->son.push_back((yyvsp[-1].no));}
#line 1838 "part.tab.cpp"
    break;

  case 44:
#line 250 "part.ypp"
                                                                        {}
#line 1844 "part.tab.cpp"
    break;

  case 45:
#line 251 "part.ypp"
                                                                        {(yyval.no) = new GrammaNode(lineno, Stmt_Exp_,"Stmt_Exp"); (yyval.no)->son.push_back((yyvsp[-1].no));}
#line 1850 "part.tab.cpp"
    break;

  case 46:
#line 252 "part.ypp"
                                                                        {(yyval.no)=(yyvsp[0].no);}
#line 1856 "part.tab.cpp"
    break;

  case 47:
#line 253 "part.ypp"
                                    {
		// scopePush();
		(yyval.no) = new GrammaNode(lineno, Stmt_If_,"Stmt_If");
		(yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[0].no));
		// scopePop();
	}
#line 1867 "part.tab.cpp"
    break;

  case 48:
#line 259 "part.ypp"
                                              {
		// scopePush();
		(yyval.no) = new GrammaNode(lineno, Stmt_IfElse_,"Stmt_IfElse");
		(yyval.no)->son.push_back((yyvsp[-4].no));(yyval.no)->son.push_back((yyvsp[-2].no));
		(yyval.no)->son.push_back((yyvsp[0].no));
		// scopePop();
	}
#line 1879 "part.tab.cpp"
    break;

  case 49:
#line 266 "part.ypp"
                                       {
		// scopePush();
		(yyval.no) = new GrammaNode(lineno, Stmt_While_,"Stmt_While");
		(yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[0].no));
		// scopePop();
	}
#line 1890 "part.tab.cpp"
    break;

  case 50:
#line 272 "part.ypp"
                                                                        {(yyval.no)=(yyvsp[-1].no);}
#line 1896 "part.tab.cpp"
    break;

  case 51:
#line 273 "part.ypp"
                                                                {(yyval.no)=(yyvsp[-1].no);}
#line 1902 "part.tab.cpp"
    break;

  case 52:
#line 274 "part.ypp"
                                                                {(yyval.no)=(yyvsp[-1].no);}
#line 1908 "part.tab.cpp"
    break;

  case 53:
#line 275 "part.ypp"
                                                                {(yyval.no) = new GrammaNode(lineno, Stmt_Return_,"Stmt_Return"); (yyval.no)->son.push_back((yyvsp[-1].no));}
#line 1914 "part.tab.cpp"
    break;

  case 54:
#line 279 "part.ypp"
                        {(yyval.no) = new GrammaNode(lineno, Cond_,"Cond"); (yyval.no)->son.push_back((yyvsp[0].no));}
#line 1920 "part.tab.cpp"
    break;

  case 55:
#line 284 "part.ypp"
                                                                        {(yyval.no) = new GrammaNode(lineno, ConstExps_,"ConstExps");(yyval.no)->son.push_back((yyvsp[0].no)); }
#line 1926 "part.tab.cpp"
    break;

  case 56:
#line 285 "part.ypp"
                                                {(yyvsp[-3].no)->son.push_back((yyvsp[0].no));}
#line 1932 "part.tab.cpp"
    break;

  case 57:
#line 290 "part.ypp"
                                                        {(yyval.no) =(yyvsp[0].no);}
#line 1938 "part.tab.cpp"
    break;

  case 58:
#line 296 "part.ypp"
                   {
		GrammaNode* n = IdentDefineCheck((yyvsp[-1].no));
		(yyval.no) = new GrammaNode(lineno, LVal_Array_,"LVal_");
		(yyval.no)->son.push_back(n);(yyval.no)->son.push_back((yyvsp[0].no));
	}
#line 1948 "part.tab.cpp"
    break;

  case 59:
#line 301 "part.ypp"
           {
		GrammaNode* n = IdentDefineCheck((yyvsp[0].no));
		(yyval.no) = n;
	}
#line 1957 "part.tab.cpp"
    break;

  case 60:
#line 309 "part.ypp"
                                                {(yyval.no) = new GrammaNode(lineno, Exps_,"Exps_"); (yyval.no)->son.push_back((yyvsp[-1].no));}
#line 1963 "part.tab.cpp"
    break;

  case 61:
#line 310 "part.ypp"
                                        {(yyvsp[-3].no)->son.push_back((yyvsp[-1].no));}
#line 1969 "part.tab.cpp"
    break;

  case 62:
#line 315 "part.ypp"
                                                {(yyval.no)=(yyvsp[-1].no);}
#line 1975 "part.tab.cpp"
    break;

  case 63:
#line 316 "part.ypp"
                                                        {(yyval.no)=(yyvsp[0].no);}
#line 1981 "part.tab.cpp"
    break;

  case 64:
#line 317 "part.ypp"
                                                        {(yyval.no)=(yyvsp[0].no);}
#line 1987 "part.tab.cpp"
    break;

  case 65:
#line 324 "part.ypp"
                   {(yyval.no) = (yyvsp[0].no);}
#line 1993 "part.tab.cpp"
    break;

  case 66:
#line 325 "part.ypp"
                             {
		GrammaNode* n = IdentDefineCheck((yyvsp[-2].no));
		(yyval.no) = new GrammaNode(lineno, UnaryExp_func_,"UnaryExp_func_");
		(yyval.no)->son.push_back(n);
	}
#line 2003 "part.tab.cpp"
    break;

  case 67:
#line 330 "part.ypp"
                                         {
		GrammaNode* n = IdentDefineCheck((yyvsp[-3].no));
		(yyval.no) = new GrammaNode(lineno, UnaryExp_func_,"UnaryExp_func_");
		(yyval.no)->son.push_back(n);(yyval.no)->son.push_back((yyvsp[-1].no));
	}
#line 2013 "part.tab.cpp"
    break;

  case 68:
#line 335 "part.ypp"
                          {(yyval.no) = new GrammaNode(lineno, UnaryExp_,"UnaryExp_"); (yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 2019 "part.tab.cpp"
    break;

  case 69:
#line 340 "part.ypp"
                                                {(yyval.no)=(yyvsp[0].no);}
#line 2025 "part.tab.cpp"
    break;

  case 70:
#line 341 "part.ypp"
                                        {(yyval.no)=(yyvsp[0].no);}
#line 2031 "part.tab.cpp"
    break;

  case 71:
#line 342 "part.ypp"
                                        {(yyval.no)=(yyvsp[0].no);}
#line 2037 "part.tab.cpp"
    break;

  case 72:
#line 352 "part.ypp"
                                                        {(yyval.no) = new GrammaNode(lineno, FuncRParams_,"FuncRParams_"); (yyval.no)->son.push_back((yyvsp[0].no));}
#line 2043 "part.tab.cpp"
    break;

  case 73:
#line 353 "part.ypp"
                                {(yyvsp[-2].no)->son.push_back((yyvsp[0].no));}
#line 2049 "part.tab.cpp"
    break;

  case 74:
#line 358 "part.ypp"
                                                        {(yyval.no) = (yyvsp[0].no);}
#line 2055 "part.tab.cpp"
    break;

  case 75:
#line 359 "part.ypp"
                                {(yyval.no) = new GrammaNode(lineno, MulExp_Mul_,"MulExp_Mul"); (yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 2061 "part.tab.cpp"
    break;

  case 76:
#line 360 "part.ypp"
                                {(yyval.no) = new GrammaNode(lineno, MulExp_Div_,"MulExp_Div"); (yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 2067 "part.tab.cpp"
    break;

  case 77:
#line 361 "part.ypp"
                                {(yyval.no) = new GrammaNode(lineno, MulExp_Mod_,"MulExp_Mod"); (yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 2073 "part.tab.cpp"
    break;

  case 78:
#line 366 "part.ypp"
                                        {(yyval.no)=(yyvsp[0].no);}
#line 2079 "part.tab.cpp"
    break;

  case 79:
#line 367 "part.ypp"
                                {(yyval.no) = new GrammaNode(lineno, AddExp_Add_,"AddExp_Add"); (yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 2085 "part.tab.cpp"
    break;

  case 80:
#line 368 "part.ypp"
                                {(yyval.no) = new GrammaNode(lineno, AddExp_Sub_,"AddExp_Sub"); (yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 2091 "part.tab.cpp"
    break;

  case 81:
#line 372 "part.ypp"
                                        {(yyval.no) = (yyvsp[0].no);}
#line 2097 "part.tab.cpp"
    break;

  case 82:
#line 373 "part.ypp"
                                {(yyval.no) = new GrammaNode(lineno, RelExp_LT_,"RelExp_LT"); (yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 2103 "part.tab.cpp"
    break;

  case 83:
#line 374 "part.ypp"
                                {(yyval.no) = new GrammaNode(lineno, RelExp_BG_,"RelExp_BG"); (yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 2109 "part.tab.cpp"
    break;

  case 84:
#line 375 "part.ypp"
                                {(yyval.no) = new GrammaNode(lineno, RelExp_LQ_,"RelExp_LQ"); (yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 2115 "part.tab.cpp"
    break;

  case 85:
#line 376 "part.ypp"
                                {(yyval.no) = new GrammaNode(lineno, RelExp_BQ_,"RelExp_BQ"); (yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 2121 "part.tab.cpp"
    break;

  case 86:
#line 380 "part.ypp"
                                        {(yyval.no) = (yyvsp[0].no);}
#line 2127 "part.tab.cpp"
    break;

  case 87:
#line 381 "part.ypp"
                                {(yyval.no) = new GrammaNode(lineno, EqExp_EQ_,"EqExp_EQ"); (yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 2133 "part.tab.cpp"
    break;

  case 88:
#line 382 "part.ypp"
                                {(yyval.no) = new GrammaNode(lineno, EqExp_NEQ_,"EqExp_NEQ"); (yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 2139 "part.tab.cpp"
    break;

  case 89:
#line 386 "part.ypp"
                                        {(yyval.no) = new GrammaNode(lineno, LAndExp_,"LAndExp"); (yyval.no)->son.push_back((yyvsp[0].no));}
#line 2145 "part.tab.cpp"
    break;

  case 90:
#line 387 "part.ypp"
                                {(yyvsp[-2].no)->son.push_back((yyvsp[0].no));}
#line 2151 "part.tab.cpp"
    break;

  case 91:
#line 391 "part.ypp"
                                        {(yyval.no) = new GrammaNode(lineno, LOrExp_,"LOrExp"); (yyval.no)->son.push_back((yyvsp[0].no));}
#line 2157 "part.tab.cpp"
    break;

  case 92:
#line 392 "part.ypp"
                                {(yyvsp[-2].no)->son.push_back((yyvsp[0].no));}
#line 2163 "part.tab.cpp"
    break;

  case 93:
#line 398 "part.ypp"
                        {(yyval.no) = (yyvsp[0].no);}
#line 2169 "part.tab.cpp"
    break;

  case 94:
#line 399 "part.ypp"
                        {(yyval.no) = (yyvsp[0].no);}
#line 2175 "part.tab.cpp"
    break;

  case 95:
#line 400 "part.ypp"
                        {(yyval.no) = (yyvsp[0].no);}
#line 2181 "part.tab.cpp"
    break;

  case 96:
#line 401 "part.ypp"
                                {(yyval.no) = (yyvsp[0].no);}
#line 2187 "part.tab.cpp"
    break;


#line 2191 "part.tab.cpp"

      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */
  {
    const int yylhs = yyr1[yyn] - YYNTOKENS;
    const int yyi = yypgoto[yylhs] + *yyssp;
    yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyssp
               ? yytable[yyi]
               : yydefgoto[yylhs]);
  }

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = YY_CAST (char *, YYSTACK_ALLOC (YY_CAST (YYSIZE_T, yymsg_alloc)));
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:
  /* Pacify compilers when the user code never invokes YYERROR and the
     label yyerrorlab therefore never appears in user code.  */
  if (0)
    YYERROR;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;


/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;


#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif


/*-----------------------------------------------------.
| yyreturn -- parsing is finished, return the result.  |
`-----------------------------------------------------*/
yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[+*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
#line 408 "part.ypp"


void yyerror(char const *message)
{
	string l = "\033[43;34m" + to_string(lineno) + " \033[0m ";
	cout << "\033[31m[ERROR]\033[0m " << message << " at " << "\033[43;34m line \033[0m" << l << endl;
	return;
}

//-----------用于处理Identifier的声明：检查是否重复定义-----------
//出现重复声明则报错、否则将其加入俩map中
void IdentDeclareCheck(GrammaNode* deIdent)
{
	deIdent->var_scope = presentScope; // 更新该节点的作用域
	//在idList变量列表中查找是否有名字相同且作用域相同的变量
	if(idList.count(make_pair(deIdent->str, deIdent->var_scope)) != 0)
	{//如果找到了，为真，则重复定义
		string m = "Redeclared identifier: '" + deIdent->str + "'";
		yyerror(m.c_str());
	}
	//否则就将该变量加入idList和idNameList中
	idNameList.insert(make_pair(deIdent->str, deIdent->var_scope));
	idList[make_pair(deIdent->str, deIdent->var_scope)] = deIdent;
}

//-----------用于处理Identifier的定义：检查是否未定义-----------
//未定义则报错
GrammaNode* IdentDefineCheck(GrammaNode* deIdent)
{
	GrammaNode* res = deIdent;
	int idNameCount = idNameList.count(deIdent->str); //在idNameList中搜索有多少个一样的Ident
	int declCnt = 0;
	int minDefDis = MAX_SCOPE_STACK;

	auto it = idNameList.find(deIdent->str); // 相同变量名的Ident的迭代器
	int resScoptCmp; // 作用域比较scopeCmp函数的返回值
	while(idNameCount--)
	{
		resScoptCmp = scopeCmp(presentScope, it->second);
		if(resScoptCmp >= 0)
		{// 寻找距离最近的定义
			if(resScoptCmp < minDefDis)
			{
				minDefDis = resScoptCmp;
				//返回idList中同名且作用域相同的GrammaNode指针
				res = idList[make_pair(it->first, it->second)];
			}
			declCnt++;
		}
		it++;
	}

	//啥都没找见
	if(declCnt == 0)
	{
		string m = "Undeclared identifier :'" + deIdent->str + "', scope : " + to_string(resScoptCmp);
		yyerror(m.c_str());
	}

	return res;
}
/*
 *	作用域比较函数 int scopeCmp (string, string)
 *
 *  输入参数： 
 *    presScope： 当前变量所处的作用域
 *    varScope:   希望进行比较的已声明变量作用域
 *
 *  返回值：
 *    0： 作用域相同，
 *          若为变量声明语句，为变量重定义。
 *   >0： 已声明变量作用域在当前作用域外层，返回作用域距离（堆栈层数）
 *          若为声明语句，不产生冲突，当前变量为新定义变量，
 *          若为使用语句，当前变量为新定义变量。
 *   -1：已声明变量作用域在当前作用域内层，
 *          若为声明语句，不可能出现这种情况，
 *          若为使用语句，不产生冲突。
 *   -2：两个作用域互不包含，任何情况下都不会互相干扰
 */
int scopeCmp(std::string presScope, std::string varScope) {
	unsigned int plen = presScope.length(), vlen = varScope.length();
	unsigned int minlen = min(plen, vlen);
	if (presScope.substr(0, minlen) == varScope.substr(0, minlen)) {
		if (plen >= vlen)
			return plen - vlen;
		else
			return -1;
	}
	return -2;
}


void scopePush()
{
	presentScope += max_scope_id;
	max_scope_id = SCOPT_ID_BASE; // 又赋一次值
	top++;
#ifdef DEBUG_SCOPE
	cout << "* push -> " << presentScope << ", at line " << lineno << endl;
#endif
}

void scopePop()
{
	
	max_scope_id = presentScope[top] + 1;
	presentScope = presentScope.substr(0, presentScope.length() - 1);
	top--;
#ifdef DEBUG_SCOPE
	cout << "*  pop -> " << presentScope << ", at line " << lineno << endl;
#endif
}

/*
 *	变量作用域切换只会发生在以下地方：
 *
 *		函数体		type funcName ( params ) block
 *								  ↑ push		  ↑ pop
 *
 *		block块		{ stmts }
 *					↑ push	↑ pop
 *
 *		if语句		IF ( cond ) block
 *					↑ push			  ↑ pop
 *
 *					IF ( cond ) block ELSE block
 *					↑ push						 ↑ pop
 *
 *		while语句	WHILE ( cond ) block
 *					↑ push				 ↑ pop
 *
 *
 * 	可得作用域推进表：
 *
 *		push:
 *          *
 *			*
 *		pop:
 *			*
 *			*
 */
