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
	#include "sysy_node.hpp"
	#include "sysy_node.cpp"
	extern int yylex();
	void yyerror(char const *s);

#line 80 "part.tab.cpp"

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
#line 12 "part.ypp"

        struct GrammaNode *no;

#line 174 "part.tab.cpp"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);





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
typedef yytype_int8 yy_state_t;

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
#define YYFINAL  14
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   155

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  41
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  30
/* YYNRULES -- Number of rules.  */
#define YYNRULES  68
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  119

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
       0,    37,    37,    38,    39,    40,    44,    45,    50,    55,
      56,    61,    65,    66,    67,    71,    72,    76,    80,    81,
      85,    86,    90,    91,    92,    96,    97,   101,   102,   103,
     104,   113,   114,   118,   119,   120,   129,   157,   158,   163,
     168,   173,   174,   179,   180,   185,   186,   187,   192,   193,
     194,   195,   200,   201,   202,   207,   212,   213,   218,   219,
     220,   221,   226,   227,   228,   258,   259,   260,   261
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
  "ConstInitVal", "ConstInitVals", "VarDecl", "VarDefs", "VarDef",
  "InitVal", "InitVals", "FuncDef", "FuncFParams", "FuncFParam", "Block",
  "ConstExps", "ConstExp", "Exp", "LVal", "Exps", "PrimaryExp", "UnaryExp",
  "UnaryOp", "FuncRParamse", "FuncRParams", "MulExp", "AddExp", "IntConst", YY_NULLPTR
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

#define YYPACT_NINF (-83)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-1)

#define yytable_value_is_error(Yyn) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int8 yypact[] =
{
      47,   -26,    -9,   -19,    20,   -83,   -83,   -83,   -83,    35,
      25,   -83,    10,    51,   -83,   -83,   -83,    -2,    16,   -83,
      43,   -83,    63,   -83,     6,    50,    53,    71,   -83,    59,
     115,   -83,   -83,    58,   -83,    10,    50,    87,    91,   -83,
      88,    77,    50,   115,    -3,   -83,   -83,   -83,   -83,   -83,
     -83,   -83,    32,   -83,   -83,   -83,   -83,   -83,   115,    66,
      74,   -83,    96,    74,    85,   -83,   -83,    50,   -83,    99,
     -83,   -83,   102,   -83,   -83,     1,   100,   115,   109,   -83,
     115,   115,   115,   115,   115,   -83,    33,   -83,   -83,   -83,
     111,   -83,    59,   -83,   -83,   -83,   103,   117,   114,   115,
     -83,   -83,   -83,    66,    66,   -83,   -83,    11,   109,   -83,
     -83,   115,   -83,   123,    85,   -83,   -83,   -83,   -83
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_int8 yydefact[] =
{
       0,     0,     0,     0,     0,     2,     6,     7,     3,    37,
       0,    18,     0,     0,     1,     4,     5,     0,    21,    17,
       0,    37,     0,     9,     0,     0,     0,     0,    31,     0,
       0,    37,    19,     0,     8,     0,     0,     0,     0,    27,
      33,     0,     0,     0,     0,    52,    53,    54,    68,    65,
      66,    67,    42,    20,    22,    46,    48,    58,     0,    62,
      40,    47,     0,    39,     0,    10,    28,     0,    36,     0,
      32,    29,     0,    23,    25,     0,     0,     0,    41,    51,
       0,     0,     0,     0,     0,    38,     0,    11,    12,    30,
      35,    45,     0,    24,    49,    56,     0,    55,     0,     0,
      60,    59,    61,    63,    64,    13,    15,     0,    34,    26,
      50,     0,    43,     0,     0,    14,    57,    44,    16
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
     -83,   -83,   116,   -83,   -83,    89,   -82,   -83,   -83,   -83,
     118,   -43,   -83,   130,   112,    94,   -25,   121,   107,   -41,
     -83,    49,   -83,   -27,   -83,   -83,   -83,    17,   -30,   -83
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
      -1,     4,     5,     6,    22,    23,    87,   107,     7,    10,
      11,    53,    75,     8,    27,    28,    39,    18,    88,    54,
      55,    78,    56,    57,    58,    96,    97,    59,    60,    61
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int8 yytable[] =
{
      63,    74,    72,    43,   106,    25,    92,    44,    73,    45,
      46,    66,    93,    36,     9,    47,   114,    71,    12,    29,
      14,    13,   115,    48,    30,    26,    49,    50,    51,    19,
      20,    79,   118,    26,    63,    95,    98,    52,    76,    43,
      77,    17,    89,    86,   105,    45,    46,     1,     2,   109,
      21,    47,     3,   100,   101,   102,    63,    24,   113,    48,
      38,    64,    49,    50,    51,    43,    30,    34,    35,    44,
     116,    45,    46,    52,     1,     2,    41,    47,    42,     3,
      80,    81,    82,    31,    63,    48,    83,    84,    49,    50,
      51,    43,    41,    40,    67,    86,    69,    45,    46,    52,
     103,   104,    68,    47,    26,    85,    43,    94,    90,    91,
     110,    48,    45,    46,    49,    50,    51,    99,    47,    77,
      15,    43,   111,   112,    65,    52,    48,    45,    46,    49,
      50,    51,   117,    47,    16,    70,    37,    62,    32,   108,
      52,    48,    33,     0,    49,    50,    51,     0,     0,     0,
       0,     0,     0,     0,     0,    52
};

static const yytype_int8 yycheck[] =
{
      30,    44,    43,     6,    86,     7,     5,    10,    11,    12,
      13,    36,    11,     7,    40,    18,     5,    42,    27,     3,
       0,    40,    11,    26,     8,    27,    29,    30,    31,     4,
       5,    58,   114,    27,    64,    76,    77,    40,     6,     6,
       8,     6,    67,    10,    11,    12,    13,    27,    28,    92,
      40,    18,    32,    80,    81,    82,    86,     6,    99,    26,
      10,     3,    29,    30,    31,     6,     8,     4,     5,    10,
     111,    12,    13,    40,    27,    28,     5,    18,     7,    32,
      14,    15,    16,    40,   114,    26,    12,    13,    29,    30,
      31,     6,     5,    40,     7,    10,     8,    12,    13,    40,
      83,    84,    11,    18,    27,     9,     6,     7,     9,     7,
       7,    26,    12,    13,    29,    30,    31,     8,    18,     8,
       4,     6,     5,     9,    35,    40,    26,    12,    13,    29,
      30,    31,     9,    18,     4,    41,    24,    30,    20,    90,
      40,    26,    21,    -1,    29,    30,    31,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    40
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_int8 yystos[] =
{
       0,    27,    28,    32,    42,    43,    44,    49,    54,    40,
      50,    51,    27,    40,     0,    43,    54,     6,    58,     4,
       5,    40,    45,    46,     6,     7,    27,    55,    56,     3,
       8,    40,    51,    58,     4,     5,     7,    55,    10,    57,
      40,     5,     7,     6,    10,    12,    13,    18,    26,    29,
      30,    31,    40,    52,    60,    61,    63,    64,    65,    68,
      69,    70,    59,    69,     3,    46,    57,     7,    11,     8,
      56,    57,    60,    11,    52,    53,     6,     8,    62,    64,
      14,    15,    16,    12,    13,     9,    10,    47,    59,    57,
       9,     7,     5,    11,     7,    60,    66,    67,    60,     8,
      64,    64,    64,    68,    68,    11,    47,    48,    62,    52,
       7,     5,     9,    60,     5,    11,    60,     9,    47
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_int8 yyr1[] =
{
       0,    41,    42,    42,    42,    42,    43,    43,    44,    45,
      45,    46,    47,    47,    47,    48,    48,    49,    50,    50,
      51,    51,    52,    52,    52,    53,    53,    54,    54,    54,
      54,    55,    55,    56,    56,    56,    57,    58,    58,    59,
      60,    61,    61,    62,    62,    63,    63,    63,    64,    64,
      64,    64,    65,    65,    65,    66,    67,    67,    68,    68,
      68,    68,    69,    69,    69,    70,    70,    70,    70
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     1,     1,     2,     2,     1,     1,     4,     1,
       3,     4,     1,     2,     3,     1,     3,     3,     1,     3,
       4,     2,     1,     2,     3,     1,     3,     5,     5,     6,
       6,     1,     3,     2,     5,     4,     2,     0,     4,     1,
       1,     2,     1,     3,     4,     3,     1,     1,     1,     3,
       4,     2,     1,     1,     1,     1,     1,     3,     1,     3,
       3,     3,     1,     3,     3,     1,     1,     1,     1
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
#line 37 "part.ypp"
                                        {(yyval.no)=new GrammaNode(CompUnit_,"CompUnit");(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1437 "part.tab.cpp"
    break;

  case 3:
#line 38 "part.ypp"
                                        {(yyval.no)=new GrammaNode(CompUnit_,"CompUnit");(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1443 "part.tab.cpp"
    break;

  case 4:
#line 39 "part.ypp"
                                {(yyval.no)=new GrammaNode(CompUnit_,"CompUnit");(yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1449 "part.tab.cpp"
    break;

  case 5:
#line 40 "part.ypp"
                                {(yyval.no)=new GrammaNode(CompUnit_,"CompUnit");(yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1455 "part.tab.cpp"
    break;

  case 6:
#line 44 "part.ypp"
              {(yyval.no)=new GrammaNode(Decl_,"Decl_");(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1461 "part.tab.cpp"
    break;

  case 7:
#line 45 "part.ypp"
                  {(yyval.no)=new GrammaNode(Decl_,"Decl_");(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1467 "part.tab.cpp"
    break;

  case 8:
#line 50 "part.ypp"
                                  {(yyval.no)=new GrammaNode(ConstDecl_,"ConstDecl_");(yyval.no)->son.push_back((yyvsp[-3].no));(yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1473 "part.tab.cpp"
    break;

  case 9:
#line 55 "part.ypp"
                                                                {(yyval.no)=new GrammaNode(ConstDefs_,"ConstDefs_");(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1479 "part.tab.cpp"
    break;

  case 10:
#line 56 "part.ypp"
                                                {(yyval.no) = new GrammaNode(ConstDefs_,"ConstDefs_"); (yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1485 "part.tab.cpp"
    break;

  case 11:
#line 61 "part.ypp"
                                     {(yyval.no) = new GrammaNode(ConstDef_,"ConstDef_"); (yyval.no)->son.push_back((yyvsp[-3].no));(yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1491 "part.tab.cpp"
    break;

  case 12:
#line 65 "part.ypp"
                                                                {(yyval.no) = new GrammaNode(ConstInitVal_,"ConstInitVal_"); (yyval.no)->son.push_back((yyvsp[0].no));}
#line 1497 "part.tab.cpp"
    break;

  case 13:
#line 66 "part.ypp"
                                                                        {(yyval.no) = new GrammaNode(ConstInitVal_,"ConstInitVal_"); (yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1503 "part.tab.cpp"
    break;

  case 14:
#line 67 "part.ypp"
                                                        {(yyval.no) = new GrammaNode(ConstInitVal_,"ConstInitVal_"); (yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1509 "part.tab.cpp"
    break;

  case 15:
#line 71 "part.ypp"
                                                        {(yyval.no) = new GrammaNode(ConstInitVals_,"ConstInitVals_"); (yyval.no)->son.push_back((yyvsp[0].no));}
#line 1515 "part.tab.cpp"
    break;

  case 16:
#line 72 "part.ypp"
                                                {(yyval.no) = new GrammaNode(ConstInitVals_,"ConstInitVals_"); (yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1521 "part.tab.cpp"
    break;

  case 17:
#line 76 "part.ypp"
                                                        {(yyval.no) = new GrammaNode(VarDecl_,"VarDecl"); (yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1527 "part.tab.cpp"
    break;

  case 18:
#line 80 "part.ypp"
                                                                {(yyval.no) = new GrammaNode(VarDefs_,"VarDefs"); (yyval.no)->son.push_back((yyvsp[0].no));}
#line 1533 "part.tab.cpp"
    break;

  case 19:
#line 81 "part.ypp"
                                                {(yyval.no) = new GrammaNode(VarDefs_,"VarDefs"); (yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1539 "part.tab.cpp"
    break;

  case 20:
#line 85 "part.ypp"
                                        {(yyval.no) = new GrammaNode(VarDef_,"VarDef"); (yyval.no)->son.push_back((yyvsp[-3].no));(yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1545 "part.tab.cpp"
    break;

  case 21:
#line 86 "part.ypp"
                                                        {(yyval.no) = new GrammaNode(VarDef_,"VarDef"); (yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1551 "part.tab.cpp"
    break;

  case 22:
#line 90 "part.ypp"
                                                                        {(yyval.no) = new GrammaNode(InitVal_,"InitVal"); (yyval.no)->son.push_back((yyvsp[0].no));}
#line 1557 "part.tab.cpp"
    break;

  case 23:
#line 91 "part.ypp"
                                                                {(yyval.no) = new GrammaNode(InitVal_,"InitVal"); (yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1563 "part.tab.cpp"
    break;

  case 24:
#line 92 "part.ypp"
                                                        {(yyval.no) = new GrammaNode(InitVal_,"InitVal"); (yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1569 "part.tab.cpp"
    break;

  case 25:
#line 96 "part.ypp"
                                                                {(yyval.no) = new GrammaNode(InitVals_,"InitVals"); (yyval.no)->son.push_back((yyvsp[0].no));}
#line 1575 "part.tab.cpp"
    break;

  case 26:
#line 97 "part.ypp"
                                                {(yyval.no) = new GrammaNode(InitVals_,"InitVals"); (yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1581 "part.tab.cpp"
    break;

  case 27:
#line 101 "part.ypp"
                                                        {(yyval.no) = new GrammaNode(FuncDef_,"FuncDef"); (yyval.no)->son.push_back((yyvsp[-4].no));(yyval.no)->son.push_back((yyvsp[-3].no));(yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1587 "part.tab.cpp"
    break;

  case 28:
#line 102 "part.ypp"
                                                        {(yyval.no) = new GrammaNode(FuncDef_,"FuncDef"); (yyval.no)->son.push_back((yyvsp[-4].no));(yyval.no)->son.push_back((yyvsp[-3].no));(yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1593 "part.tab.cpp"
    break;

  case 29:
#line 103 "part.ypp"
                                                   {(yyval.no) = new GrammaNode(FuncDef_,"FuncDef"); (yyval.no)->son.push_back((yyvsp[-5].no));(yyval.no)->son.push_back((yyvsp[-4].no));(yyval.no)->son.push_back((yyvsp[-3].no));(yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1599 "part.tab.cpp"
    break;

  case 30:
#line 104 "part.ypp"
                                                    {(yyval.no) = new GrammaNode(FuncDef_,"FuncDef"); (yyval.no)->son.push_back((yyvsp[-5].no));(yyval.no)->son.push_back((yyvsp[-4].no));(yyval.no)->son.push_back((yyvsp[-3].no));(yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1605 "part.tab.cpp"
    break;

  case 31:
#line 113 "part.ypp"
                                                                        {(yyval.no) = new GrammaNode(FuncFParams_,"FuncFParams"); (yyval.no)->son.push_back((yyvsp[0].no));}
#line 1611 "part.tab.cpp"
    break;

  case 32:
#line 114 "part.ypp"
                                                {(yyval.no) = new GrammaNode(FuncFParams_,"FuncFParams"); (yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1617 "part.tab.cpp"
    break;

  case 33:
#line 118 "part.ypp"
                                                                        {(yyval.no) = new GrammaNode(FuncFParam_,"FuncFParam"); (yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1623 "part.tab.cpp"
    break;

  case 34:
#line 119 "part.ypp"
                                                {(yyval.no) = new GrammaNode(FuncFParam_,"FuncFParam"); (yyval.no)->son.push_back((yyvsp[-4].no));(yyval.no)->son.push_back((yyvsp[-3].no));(yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1629 "part.tab.cpp"
    break;

  case 35:
#line 120 "part.ypp"
                                                        {(yyval.no) = new GrammaNode(FuncFParam_,"FuncFParam"); (yyval.no)->son.push_back((yyvsp[-3].no));(yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1635 "part.tab.cpp"
    break;

  case 36:
#line 129 "part.ypp"
                                                                        {(yyval.no) = new GrammaNode(Block_,"Block"); (yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1641 "part.tab.cpp"
    break;

  case 38:
#line 158 "part.ypp"
                                                        {(yyval.no) = new GrammaNode(ConstExps_,"ConstExps"); (yyval.no)->son.push_back((yyvsp[-3].no));(yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1647 "part.tab.cpp"
    break;

  case 39:
#line 163 "part.ypp"
                                        {(yyval.no) = new GrammaNode(ConstExp_,"ConstExp_"); (yyval.no)->son.push_back((yyvsp[0].no));}
#line 1653 "part.tab.cpp"
    break;

  case 40:
#line 168 "part.ypp"
                                                        {(yyval.no) = new GrammaNode(Exp_,"Exp_"); (yyval.no)->son.push_back((yyvsp[0].no));}
#line 1659 "part.tab.cpp"
    break;

  case 41:
#line 173 "part.ypp"
                                                        {(yyval.no) = new GrammaNode(LVal_,"LVal_"); (yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1665 "part.tab.cpp"
    break;

  case 42:
#line 174 "part.ypp"
                                                        {(yyval.no) = new GrammaNode(LVal_,"LVal_"); (yyval.no)->son.push_back((yyvsp[0].no));printf("LAal->Ident\n");}
#line 1671 "part.tab.cpp"
    break;

  case 43:
#line 179 "part.ypp"
                                                {(yyval.no) = new GrammaNode(Exps_,"Exps_"); (yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1677 "part.tab.cpp"
    break;

  case 44:
#line 180 "part.ypp"
                                        {(yyval.no) = new GrammaNode(Exps_,"Exps_"); (yyval.no)->son.push_back((yyvsp[-3].no));(yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1683 "part.tab.cpp"
    break;

  case 45:
#line 185 "part.ypp"
                                {(yyval.no) = new GrammaNode(PrimaryExp_,"PrimaryExp"); (yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1689 "part.tab.cpp"
    break;

  case 46:
#line 186 "part.ypp"
                                                        {(yyval.no) = new GrammaNode(PrimaryExp_,"PrimaryExp"); (yyval.no)->son.push_back((yyvsp[0].no));}
#line 1695 "part.tab.cpp"
    break;

  case 47:
#line 187 "part.ypp"
                                                        {(yyval.no) = new GrammaNode(PrimaryExp_,"PrimaryExp"); (yyval.no)->son.push_back((yyvsp[0].no));}
#line 1701 "part.tab.cpp"
    break;

  case 48:
#line 192 "part.ypp"
                                                                {(yyval.no) = new GrammaNode(UnaryExp_,"UnaryExp_"); (yyval.no)->son.push_back((yyvsp[0].no));}
#line 1707 "part.tab.cpp"
    break;

  case 49:
#line 193 "part.ypp"
                                                {(yyval.no) = new GrammaNode(UnaryExp_,"UnaryExp_"); (yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1713 "part.tab.cpp"
    break;

  case 50:
#line 194 "part.ypp"
                                                {(yyval.no) = new GrammaNode(UnaryExp_,"UnaryExp_"); (yyval.no)->son.push_back((yyvsp[-3].no));(yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1719 "part.tab.cpp"
    break;

  case 51:
#line 195 "part.ypp"
                                                                {(yyval.no) = new GrammaNode(UnaryExp_,"UnaryExp_"); (yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1725 "part.tab.cpp"
    break;

  case 52:
#line 200 "part.ypp"
                                                {(yyval.no) = new GrammaNode(UnaryOp_,"UnaryOp_"); (yyval.no)->son.push_back((yyvsp[0].no));}
#line 1731 "part.tab.cpp"
    break;

  case 53:
#line 201 "part.ypp"
                                        {(yyval.no) = new GrammaNode(UnaryOp_,"UnaryOp_"); (yyval.no)->son.push_back((yyvsp[0].no));}
#line 1737 "part.tab.cpp"
    break;

  case 54:
#line 202 "part.ypp"
                                        {(yyval.no) = new GrammaNode(UnaryOp_,"UnaryOp_"); (yyval.no)->son.push_back((yyvsp[0].no));}
#line 1743 "part.tab.cpp"
    break;

  case 55:
#line 207 "part.ypp"
                           {(yyval.no) = new GrammaNode(FuncRParamse_,"FuncRParamse_"); (yyval.no)->son.push_back((yyvsp[0].no));}
#line 1749 "part.tab.cpp"
    break;

  case 56:
#line 212 "part.ypp"
                                                        {(yyval.no) = new GrammaNode(FuncRParams_,"FuncRParams_"); (yyval.no)->son.push_back((yyvsp[0].no));}
#line 1755 "part.tab.cpp"
    break;

  case 57:
#line 213 "part.ypp"
                                {(yyval.no) = new GrammaNode(FuncRParams_,"FuncRParams_"); (yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1761 "part.tab.cpp"
    break;

  case 58:
#line 218 "part.ypp"
                                                        {(yyval.no) = new GrammaNode(MulExp_,"MulExp_"); (yyval.no)->son.push_back((yyvsp[0].no));}
#line 1767 "part.tab.cpp"
    break;

  case 59:
#line 219 "part.ypp"
                                {(yyval.no) = new GrammaNode(MulExp_,"MulExp_"); (yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1773 "part.tab.cpp"
    break;

  case 60:
#line 220 "part.ypp"
                                {(yyval.no) = new GrammaNode(MulExp_,"MulExp_"); (yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1779 "part.tab.cpp"
    break;

  case 61:
#line 221 "part.ypp"
                                {(yyval.no) = new GrammaNode(MulExp_,"MulExp_"); (yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1785 "part.tab.cpp"
    break;

  case 62:
#line 226 "part.ypp"
                                        {(yyval.no) = new GrammaNode(AddExp_,"AddExp"); (yyval.no)->son.push_back((yyvsp[0].no));}
#line 1791 "part.tab.cpp"
    break;

  case 63:
#line 227 "part.ypp"
                                {(yyval.no) = new GrammaNode(AddExp_,"AddExp"); (yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1797 "part.tab.cpp"
    break;

  case 64:
#line 228 "part.ypp"
                                {(yyval.no) = new GrammaNode(AddExp_,"AddExp"); (yyval.no)->son.push_back((yyvsp[-2].no));(yyval.no)->son.push_back((yyvsp[-1].no));(yyval.no)->son.push_back((yyvsp[0].no));}
#line 1803 "part.tab.cpp"
    break;

  case 65:
#line 258 "part.ypp"
                        {(yyval.no) = new GrammaNode(IntConst_,"IntConst"); (yyval.no)->son.push_back((yyvsp[0].no));}
#line 1809 "part.tab.cpp"
    break;

  case 66:
#line 259 "part.ypp"
                        {(yyval.no) = new GrammaNode(IntConst_,"IntConst"); (yyval.no)->son.push_back((yyvsp[0].no));}
#line 1815 "part.tab.cpp"
    break;

  case 67:
#line 260 "part.ypp"
                        {(yyval.no) = new GrammaNode(IntConst_,"IntConst"); (yyval.no)->son.push_back((yyvsp[0].no));}
#line 1821 "part.tab.cpp"
    break;

  case 68:
#line 261 "part.ypp"
                                {(yyval.no) = new GrammaNode(IntConst_,"IntConst"); (yyval.no)->son.push_back((yyvsp[0].no));}
#line 1827 "part.tab.cpp"
    break;


#line 1831 "part.tab.cpp"

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
#line 268 "part.ypp"

main(void)
{
yyparse();
return 0;
}

void yyerror(char const *s)
{
printf("%s\n",s);
return;
}



