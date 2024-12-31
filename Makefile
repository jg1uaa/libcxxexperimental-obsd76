# $OpenBSD: Makefile,v 1.7 2024/01/26 11:51:45 robert Exp $

.include <bsd.own.mk>

.if ${COMPILER_VERSION:L} != "clang"
CC=		clang
CXX=		clang++
.endif

.if ${BUILD_CLANG:L} == "yes"

HDRDIR=		${.CURDIR}/../../../gnu/llvm/libcxx/include
SRCDIR=		${.CURDIR}/../../../gnu/llvm/libcxx/src

LOCALHDRDIR=	${.CURDIR}/include/c++/v1

.PATH:	${SRCDIR} ${SRCDIR}/experimental

LIB=		c++experimental

SRCS+=		memory_resource.cpp \
		format.cpp

CPPFLAGS+=	-Wall -DLIBCXXABI -I${HDRDIR} -I${HDRDIR}/__string.d/ \
		-I${SRCDIR} -D_LIBCPP_BUILDING_LIBRARY \
		-DLIBCXX_BUILDING_LIBCXXABI -I${LOCALHDRDIR} \
		-D_LIBCPP_ENABLE_EXPERIMENTAL -DNDEBUG

CXXFLAGS+=	-nostdlib -nostdinc++
.if empty(CXXFLAGS:M-std=*)
CXXFLAGS+=	-std=c++20
.endif

.include <bsd.lib.mk>

.else
NOPROG=
.include <bsd.prog.mk>
.endif
